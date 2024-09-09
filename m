Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F43D8E
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 03:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725850816; cv=none; b=CaHxz9dxgMQPHTIuq4NA2r1F9mjHFyfD9s41b5myLeKJeUKcJaIIG/LLhYc9CSjdD+RRoqjOXsX0lgCsdY3InUh35g0iAMeSvV0Qq8VWnTpDW6pIoT1L7RxBfAFMqXFdVIkbvRclvsF7EvJfxG+UetJsgKaBXecgEePytOf/NnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725850816; c=relaxed/simple;
	bh=rcigb5XZNzyjE1tI26XgjecyBUr2a3l+eKubfBdJfO0=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=In9LdXfpc2KkDDPAro6XdNJ89wiM5FTHUD/9UCfyPK7WEYab+9/BRIIS9L/YlokISZRI9Q9nPc6C9f/MYN8mR8Ba06NMMppZttW256DNntnV5JI6/fcc+Q4YbPnk67dLhRc05TpEDIDNOf0TTIuS4vBV0R7LfkadG8QypOtOr2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bthK7hEk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bthK7hEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725850813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eEBfc33Xa3AfYX1vfhNJunyPpJBsf5woUOWQndaBnZ8=;
	b=bthK7hEknfEpdMieeJUej8yrJC8MsPgjK3IurrkBdMdWNfjPXor61J+UkUWpPN+EeNRYgL
	j/sc7O+nWF/e5Za4x/7Aj22uLvv78MWm09mwjmAZgYu4KgvwmYgVZb8ccumi0kotYJMl6K
	wJr3Wicr/j74qvx0WHyou18dKkHUFD4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-U-eJewHxPHef--ZxOrPdDw-1; Sun,
 08 Sep 2024 23:00:12 -0400
X-MC-Unique: U-eJewHxPHef--ZxOrPdDw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1C207196CDE5
	for <linux-perf-users@vger.kernel.org>; Mon,  9 Sep 2024 03:00:11 +0000 (UTC)
Received: from [10.22.16.6] (unknown [10.22.16.6])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CC6A01956094;
	Mon,  9 Sep 2024 03:00:09 +0000 (UTC)
Message-ID: <6c694175-22aa-431d-a71e-0b0c117020ed@redhat.com>
Date: Sun, 8 Sep 2024 23:00:08 -0400
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: perf group <linux-perf-users@vger.kernel.org>
Cc: wcohen@redhat.com, Serhei Makarov <smakarov@redhat.com>
Content-Language: en-US
From: William Cohen <wcohen@redhat.com>
Subject: [RFE] Improve handling of framepointer-based backtraces for function
 prologue samples
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

TL;DR summary: Estimate over 5% of cycle-based samples are taken in
function prologues. Would like better indication of when that occurs
in perf output and if possible improve perf to record enough info to
avoid missing functions in the FP-based backtraces.



The use of frame pointer-based (FP) stack unwinding has been touted as
a way of getting better backtrace samples.  However, this is
predicated on the assumption that the FP for the function has been
initialized.  If the FP for the current function has not been setup,
the unwinder will omit the function that called the current function.
For code layout optimization that most immediate call is probably the
call we care most about in the backtrace.  The question is how often
does the FP based unwinding omit the caller function that called the
function in the current sample hasn't been analyzed.  One concern is
that sample in the function prologue might be more common than
expected in cycle-based sampling as calls to function might trigger
expensive TLB or cache misses to pull in the code for the called
function.

To get some actual measurements on how often samples might occur in
code I examined disassembled x86_64, aarch64, and risc-v code to find
out what the mininmal prologues are:

x86_64:
   3532c:	f3 0f 1e fa          	endbr64
   35330:	55                   	push   %rbp
   35331:	48 89 e5             	mov	%rsp,%rbp
   35334:	53                   	push   %rbx    	// FP valid here

aarch64:
   3265c:   	d503233f    	paciasp
   32660:   	a9bc7bfd    	stp 	x29, x30, [sp, #-64]!
   32664:   	910003fd    	mov 	x29, sp
   32668:   	a90153f3    	stp 	x19, x20, [sp, #16] // FP valid

risc-v:
   38eb2:   	1141                	addi	sp,sp,-16
   38eb4:   	e022                	sd  	s0,0(sp)
   38eb6:   	e406                	sd  	ra,8(sp)
   38eb8:   	0800                	addi	s0,sp,16
   38eba:   	0001                	nop // FP valid here

Note that these are the shortest prologues possible. There are cases
where the prologue has to compute needed stack space or operations
from the body of the function have been moved into the prologue code.
Thus, for this experiment the FP is not be valid for x86_64 and risc-v
until at least an offset of 8 bytes from the start of the function.
For aarch64 this the FP is not be valid until at least 12 bytes from
the start of the function.

To collect data in one window running system-wide sampling for 10
minutes:

  sudo perf record -a sleep 600

In another running the systemtap testsuite to provide some load with systemtap:

  cd /usr/share/systemtap/testsuite
  sudo make installcheck


Once data collected can get compute the number of samples definitely
in the prologue of x86_64 and risc-v with something like following
(for aarch64 would change to 0x[0123456789ab]:

  sudo perf report --sort=sample,symoff | grep -E '0x[01234567]$' |grep -v "[k]" |grep -v "@plt" | awk '{print $2}' | paste -sd+ | bc

Obtain total sample count with:

  sudo perf report --sort=sample,dso  | awk '{print $2}' | grep '[[:digit:]]' |  paste -sd+ | bc

Obtain count of kernel samples:

  sudo perf report --sort=sample,symoff |grep "\\[k\\]" | awk '{print $2}' | paste -sd+ | bc

Obtain count of user samples by subtracing the kernel samples from the total samples.



			x86-64		aarch64		risc-v
total sample		1955552		4564540		4936702
# k-space		 345895		1034297		1323405
# u-space		1609657		3530243		3613297
# prologue		  84506		 210245		 262926
prologue/u-space	  5.2%		6.0%		 7.3%


Note these estimates are not exact, but it is possible that they may
be low due to:

  -A number of glibc optimized functions written in assembly without FP
  -Additional code to compute stack space based on arguments
  -Function optimization:
    -Moving loads into prologue to allow more time for load to complete
    -Skipping directly to return if argument is NULL (observed in riscv libelf gelf_getsymshndx and elf_getscn)


It would be an improvement in perf to include some information when
reporting backtrace information which backtraces have skipped a
function in the call backtraces.  For processors that store the return
address in a register like the aarch64 and risc-v record that register
in the sample and use it for samples in the prologue to get a more
complete backtrace.  Unfortunately for x86_64 the return value could
be anywhere on the stack relative to the current value of the stack
pointer.  Maybe could analyze the CFI information of x86_64 programs
to provide a reasonable small amount of stack to record that covers a
significant portion of function prologues.

-Will Cohen

