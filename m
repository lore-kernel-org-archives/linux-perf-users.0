Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BC7F327208
	for <linux-perf-users@vger.kernel.org>; Thu, 30 Oct 2025 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761807194; cv=none; b=EyB67CPGsFIJj+r7Yq6XOtKrLdgBFWAAVfqSuIRf02mb4w7Wp5FYda1otauypDDeF7txMKSaInzVpWWAKh45E7pJWGTxfR6i+XuxnpEgzJthLsCfSu9DZXd4nN+MHhdX1IuOKgTxxILubeNqllAYyvDCFIViXUpztiPVawe4gRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761807194; c=relaxed/simple;
	bh=9J9czWWBHuDjTnMXNqrgKH8n4iTNriA7SntDv5e27So=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MUJ5MZyNGHspF3I1w8kcF40P6ZsxHGBl9oJtPgRgPQW2nSW4UrEH0UNnErhemBhxnwFxoFo0GjErattdMTeki4dwlclzvlY9jIKmYns7VlreiBNpgXeb8zMsUScaTmAhL2Nn3wX+W353uXFzTzQ8f3w9FmettJKunBxQUN+la3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sourceware.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-340564186e0so329823a91.0
        for <linux-perf-users@vger.kernel.org>; Wed, 29 Oct 2025 23:53:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761807189; x=1762411989;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7560MIDgm6rBZviHU/ACGxyAhG/wDS1SMryfVcaISAQ=;
        b=bBO8RDv9qMNSyQPpInQR47AKK7FVxKyp7wN6UsmULvEdva6F3UeGpls3EuwgC24+BU
         ka0rQnCcrxKUWHqpgnhLBtMeEh0QOqDKlQnt2dM2NEuT5FRFO9IHeOWp5dYxGXel/ulU
         0expNdS9MBi4oSn6nwMo+58V1J3Bl+FCLvwvWutmcdaeROsZ99iRBfb7SFLkwFOuobxn
         0iDzqyvKunhHsVJp1YwM0d3Ep8wFe767tL7KBEGv6H1eCX2o0dR7Bw2WhqdWyPoL6NUH
         NcZDF2xUf8eUxrlFnor9D1Tyu1hx/Ugi7/yBYc0twuIRDLKN9d3a87XqLVE7TBgPJT4n
         a0Pg==
X-Forwarded-Encrypted: i=1; AJvYcCXWE8VtZefQRS2r5gdPf8CroDYFUEHHU3ohUGsWBR6BQc804lHjvPT6njVcFjGsI9y1Iw2VMPEDOB52N1uDJGZu@vger.kernel.org
X-Gm-Message-State: AOJu0YzL3Abw6A2eA94btpX2Foe56a7Z/xz2+O+GLJehSsTyJOX36DFE
	RlaohkivymkkW6aEpf3JQzlEItounBYe5CM/4Odjvgm2VRPpvbR4RJ3c
X-Gm-Gg: ASbGncsuGjLTGyZc9ie/SZqUflIv5EcHSvr9BWVOs9FUqxV/+X6bMIhH+zBzsxdYEap
	XmhCqZVQjMkjNkOW9PgcyUytiqc6VCg4pkXw6PzneW2ETXHVnBmY5m77gwNfIHOwXo4aUxPxiza
	jvgQzjF9Qsty6cYug+9zJ5p7ErNwl6rzWqcI4uY/WvFdr5Fi0h1+aHGNAk5iua0wwv+yU2B7UgV
	ulQ/iFo165NbYQ8QJ4c+wiTX3d2sH6JLSIEblF0jUVJe4ZcABd1ouh1EULVdUCUC3vw83V+/t+H
	vSVWZAEn12DFIE98ebP4tZUqzmB+RaKPXqNldYcmH8NqJqznoFJI/DDHwcS9W5l0rIOxC9nVfx0
	I3wjRXlK7s/WklnEOQD9w5UxnVi9U24nOEwivLpdUwpC8CiMA3Sn2epjAXepY2uP92o5GdIiUjV
	hnHtnwKEHp8NJ4X63IEm30h/0VHl32DLYpKQfkfKA9yADrn1JphkH2
X-Google-Smtp-Source: AGHT+IGhxirvX0ieDhT0Eh+2BiJWY6MBBD2dnYARaE1WckpH/LFoOe8i1ekEXagULIxoZroSZ0epUQ==
X-Received: by 2002:a17:90b:514c:b0:336:b60f:3936 with SMTP id 98e67ed59e1d1-3403a26500bmr8082710a91.12.1761807188961;
        Wed, 29 Oct 2025 23:53:08 -0700 (PDT)
Received: from localhost (c-73-170-232-218.hsd1.ca.comcast.net. [73.170.232.218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b7127bf6accsm15970707a12.14.2025.10.29.23.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 23:53:08 -0700 (PDT)
Date: Wed, 29 Oct 2025 23:53:32 -0700
From: Fangrui Song <maskray@sourceware.org>
To: linux-toolchains@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Concerns about SFrame viability for userspace stack walking
Message-ID: <3xd4fqvwflefvsjjoagytoi3y3sf7lxqjremhe2zo5tounihe4@3ftafgryadsr>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

I've been following the SFrame discussion and wanted to share some concerns about its viability for userspace adoption, based on concrete measurements and comparison with existing compact unwind implementations in LLVM.

**Size overhead concerns**

Measurements on a x86-64 clang binary show that .sframe (8.87 MiB) is approximately 10% larger than the combined size of .eh_frame and .eh_frame_hdr (8.06 MiB total).
This is problematic because .eh_frame cannot be eliminated - it contains essential information for restoring callee-saved registers, LSDA, and personality information needed for debugging (e.g. reading local variables in a coredump) and C++ exception handling.

This means adopting SFrame would result in carrying both formats, with a large net size increase.

**Learning from existing compact unwind implementations**

It's worth noting that LLVM has had a battle-tested compact unwind format in production use since 2009 with OS X 10.6, which transitioned to using CFI directives in 2013 [1]. The efficiency gains are dramatic:

   __text section: 0x4a55470 bytes
   __unwind_info section: 0x79060 bytes (0.6% of __text)
   __eh_frame section: 0x58 bytes

   (On macOS you can check the section size with objdump --arch x86_64 -h clang and dump the unwind info with  objdump --arch x86_64 --unwind-info clang)

OpenVMS's x86-64 port, which is ELF-based, also adopted this format as documented in their "VSI OpenVMS Calling Standard" and their 2018 post: https://discourse.llvm.org/t/rfc-asynchronous-unwind-tables-attribute/59282

The compact unwind format achieves this efficiency through a two-level page table structure. It describes common frame layouts compactly and falls back to DWARF only when necessary, allowing most DWARF CFI entries to be eliminated while maintaining full functionality. For more details, see: https://faultlore.com/blah/compact-unwinding/ and the lld/MachO implemention https://github.com/llvm/llvm-project/blob/main/lld/MachO/UnwindInfoSection.cpp

**The AArch64 case: size matters even more**

The size consideration becomes even more critical for AArch64, which is heavily deployed on mobile phones.
There's an active feature request for compact unwind support in the AArch64 ABI: https://github.com/ARM-software/abi-aa/issues/344
This underscores the broader industry need for efficient unwind information that doesn't duplicate data or significantly increase binary size.

There are at least two formats the ELF one can learn from: LLVM's compact unwind format (aarch64) and Windows ARM64 Frame Unwind Code.

**Path forward**

Unless SFrame can actually replace .eh_frame (rather than supplementing it as an accelerator for linux-perf) and demonstrate sizes smaller than .eh_frame - matching the efficiency of existing compact unwind approaches — I question its practical viability for userspace.
The current design appears to add overhead rather than reduce it.
This isn't to suggest we should simply adopt the existing compact unwind format wholesale.
The x86-64 design dates back to 2009 or earlier, and there are likely improvements we can make. However, we should aim for similar or better efficiency gains.

For additional context, I've documented my detailed analysis at:

- https://maskray.me/blog/2025-09-28-remarks-on-sframe (covering mandatory index building problems, section group compliance and garbage collection issues, and version compatibility challenges)
- https://maskray.me/blog/2025-10-26-stack-walking-space-and-time-trade-offs (size analysis)

Best regards,
Fangrui

[1]: https://github.com/llvm/llvm-project/commit/58e2d3d856b7dc7b97a18cfa2aeeb927bc7e6bd5 ("Generate compact unwind encoding from CFI directives.")
