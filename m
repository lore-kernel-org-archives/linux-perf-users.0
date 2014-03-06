From: Alen Stojanov <astojanov@inf.ethz.ch>
Subject: Some troubles with perf and measuring flops
Date: Thu, 6 Mar 2014 01:55:06 +0100
Message-ID: <5317C76A.4050103@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="------------030603030201080508060603"
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from edge20.ethz.ch ([82.130.99.26]:4009 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757246AbaCFA4S (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Mar 2014 19:56:18 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

--------------030603030201080508060603
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Dear Linux Perf Users Community,

I noticed some inconsistencies with the perf tool. I would like to 
determine whether I am doing something wrong, or whether there are 
problem in the perf tool. Here is the problem:

I would like to obtain flops on a simple matrix-to-matrix multiplication 
algorithm. The code is available in the attachment as mmmtest.c. To 
obtain flops, I run the perf tool using raw counters. When I try to 
obtain flops for matrices having sizes bellow 150x150, I obtain accurate 
results. Example (anticipated flops: 100 * 100 * 100 * 2 = 2'000'000):

perf stat -e r538010 ./mmmtest 100

  Performance counter stats for './mmmtest 100':

          2,078,775 r538010

        0.003889544 seconds time elapsed


However, whenever I try to run matrices of bigger size, the reported 
flops are not even close to the flops that I am supposed to obtain 
(anticipated results: 600 * 600 * 600 * 2 = 432'000'000):

perf stat -e r538010 ./mmmtest 600

  Performance counter stats for './mmmtest 600':

      2,348,148,851 r538010

        0.955511968 seconds time elapsed


To give you more info to replicate the problem, I provide you with the 
following:

CPU: Intel(R) Xeon(R) CPU E5-2643 0 @ 3.30GHz, 8 cores
Linux Kernel: 3.11.0-12-generic
GCC Version: gcc version 4.8.1 (Ubuntu/Linaro 4.8.1-10ubuntu8)
Monitored events: FP_COMP_OPS_EXE:SSE_SCALAR_DOUBLE - Raw event: 
0x538010 (converted using libpfm4)

I have compiled the mmmtest.c using gcc -O3 -march=corei7-avx -o mmmtest 
mmmtest.c. You can also find mmmtest.s asm version in the attachment.

Do you know why does this happens ? How can I instruct perf to obtain 
accurate results ?

Greetings,
Alen

--------------030603030201080508060603
Content-Type: text/plain; charset="UTF-8"; x-mac-type=54455854;
	x-mac-creator=21526368; name="mmmtest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mmmtest.c"

#include <stdlib.h>

int m, n, k;
double *A, *B, *C;

void compute() {
	int i,j,h;
	for(i = 0; i < m; ++i) {
		for(j = 0; j < n; ++j) {
			for(h = 0; h < k; ++h) {
				C[i*n+j] += A[i*k+h] * B[h*n+j];
			}
		}
	}
}

int main(int argc, char **argv)
{
	m = atoi(argv[1]); n = m; k = m;

	A = (double *) malloc (m * k * sizeof(double));
	B = (double *) malloc (k * n * sizeof(double));
	C = (double *) malloc (m * n * sizeof(double));

	compute ();

	free(A);
	free(B);
	free(C);
}

--------------030603030201080508060603
Content-Type: text/plain; charset="UTF-8"; x-mac-type=54455854;
	x-mac-creator=21526368; name="mmmtest.s"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="mmmtest.s"

	.file	"mmmtest.c"
	.text
	.p2align 4,,15
	.globl	compute
	.type	compute, @function
compute:
.LFB14:
	.cfi_startproc
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movl	m(%rip), %r12d
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	testl	%r12d, %r12d
	jle	.L9
	movl	n(%rip), %ebp
	xorl	%ebx, %ebx
	movl	k(%rip), %esi
	movq	B(%rip), %r15
	movq	A(%rip), %rdi
	movq	C(%rip), %r11
	leal	-1(%rbp), %eax
	movslq	%ebp, %r8
	leaq	8(,%rax,8), %r13
	movslq	%esi, %r14
	salq	$3, %r8
	salq	$3, %r14
.L3:
	testl	%ebp, %ebp
	jle	.L5
	leaq	0(%r13,%r11), %r10
	movq	%r15, %r9
	movq	%r11, %rcx
	.p2align 4,,10
	.p2align 3
.L8:
	testl	%esi, %esi
	jle	.L6
	vmovsd	(%rcx), %xmm0
	movq	%r9, %rdx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L7:
	vmovsd	(%rdi,%rax,8), %xmm1
	addq	$1, %rax
	vmulsd	(%rdx), %xmm1, %xmm1
	addq	%r8, %rdx
	cmpl	%eax, %esi
	vaddsd	%xmm1, %xmm0, %xmm0
	vmovsd	%xmm0, (%rcx)
	jg	.L7
.L6:
	addq	$8, %rcx
	addq	$8, %r9
	cmpq	%r10, %rcx
	jne	.L8
.L5:
	addl	$1, %ebx
	addq	%r14, %rdi
	addq	%r8, %r11
	cmpl	%r12d, %ebx
	jne	.L3
.L9:
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE14:
	.size	compute, .-compute
	.section	.text.startup,"ax",@progbits
	.p2align 4,,15
	.globl	main
	.type	main, @function
main:
.LFB15:
	.cfi_startproc
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	movl	$10, %edx
	movq	8(%rsi), %rdi
	xorl	%esi, %esi
	call	strtol
	movl	%eax, m(%rip)
	movl	%eax, n(%rip)
	movl	%eax, k(%rip)
	imull	%eax, %eax
	movslq	%eax, %rbx
	salq	$3, %rbx
	movq	%rbx, %rdi
	call	malloc
	movq	%rbx, %rdi
	movq	%rax, A(%rip)
	call	malloc
	movq	%rbx, %rdi
	movq	%rax, B(%rip)
	call	malloc
	movq	%rax, C(%rip)
	xorl	%eax, %eax
	call	compute
	movq	A(%rip), %rdi
	call	free
	movq	B(%rip), %rdi
	call	free
	movq	C(%rip), %rdi
	call	free
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE15:
	.size	main, .-main
	.comm	C,8,8
	.comm	B,8,8
	.comm	A,8,8
	.comm	k,4,4
	.comm	n,4,4
	.comm	m,4,4
	.ident	"GCC: (Ubuntu/Linaro 4.8.1-10ubuntu8) 4.8.1"
	.section	.note.GNU-stack,"",@progbits

--------------030603030201080508060603--
