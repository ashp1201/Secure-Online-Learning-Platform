//package com.example.controller;
//
//import com.example.dto.ProgressDto;
//import com.example.entity.Progress;
//import com.example.service.ProgressService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import javax.validation.Valid;
//import java.util.List;
//
//@RestController
//@RequestMapping("/progress")
//public class ProgressController {
//
//    @Autowired
//    private ProgressService progressService;
//
//    @PostMapping("/update")
//    public ResponseEntity<Progress> update(@Valid @RequestBody ProgressDto dto) {
//        return ResponseEntity.ok(progressService.updateProgress(dto));
//    }
//
//    @GetMapping("/enrollment/{id}")
//    public ResponseEntity<List<Progress>> getByEnrollment(@PathVariable Long id) {
//        return ResponseEntity.ok(progressService.getProgressByEnrollment(id));
//    }
//}
