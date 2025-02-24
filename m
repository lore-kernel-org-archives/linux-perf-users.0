Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89725A645
	for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 16:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740413165; cv=none; b=dpnDCsGKYkF8Gmd9b0zLWEDhXJNHhIv8n3bCNpqP+ge8i7fusMatTfyS011R02SKGam2sCFgQmfyxv1PKaIk69eigM4bg85YPsaQx24Hh9VESgEFl256Yz/UvmPHol7WxP/6so9ACosFgYdRqF+Jvyyl1o+QYXzbmgGnDdM/e7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740413165; c=relaxed/simple;
	bh=YWUl+a5cX5KM4ikHh6TaNDaTlXnWy2RhWw3AzOjOCP0=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EIC/sB8AWPc1Dj+XPYs9BYeF6GzxN83lUI69z+Qt33QxyunJAP/OS25Z1I/8lxYZfIeikcbMQU2VV11INHkYGihBk/Su1Pvsw9QINDvg5n02+cakA6pduCVqBANna6gwkOqwvXmLDvbUZ6q5/ZeJBy1cTkI9nJ6vIl57CJcqczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5dee1626093so10168525a12.1
        for <linux-perf-users@vger.kernel.org>; Mon, 24 Feb 2025 08:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740413162; x=1741017962;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EcmrN+BYS4IRFQV/39dTbtFzO4rbtdB3L2PAycfaSYI=;
        b=UPR7t4DwFrHXTyS1Q05lyRLH2Hb+Y7Jxim8e4NhVKbC80I/y306xuK70DMMB8MRhoJ
         MRmJbdfEn2q4KwcxMwOSXzSfB1gb10VXrRZRcq0Iz3FRaHoFwtLpTJJER3d2YnmL3MJN
         m83YXKB42PEyE/Vr01nlv0X6NJpkMM9mumHAqRvlfcrCZNhCZBys8jW9HBMhVhdpYQ1N
         jH6rO1ZgU09O+/+3MB8cJpW5QdGVFxFOh+V411iWEXJOWU6H7XcayCNYkjsSjxDBbzpN
         09E1UizMN4I2o+ARTFwoVufrhHNmI4t7c/SojYBrJUTawph9wW+TEtFKuKeGKNfr4DVG
         regg==
X-Gm-Message-State: AOJu0Yxmx47kq7C7tQrs1nIsfZ9yNlgjAF8C3pL9tFoHaBOLR+hggDXh
	QBRHpbE4lR3pn5XkHPeC+Tl1cAwlIkck5b2d94CsDsnW+PpAOiuqbmFCmQ==
X-Gm-Gg: ASbGncvNCJBufjX3F9GvhhMH1g2F63Fu5LzpBse61RfOxV28bMkjsHxbZuu86yfWm2j
	cPtugoMWBmVkE7pqv2f1Ntu0yDJFlej1wqcfTalh9ZGPBEM6pnMywB+IN7IkuAAllQx1a9yj8Zl
	9BY0lOfN1e/YpUFARQjiRhutL9oBNKUrEuBZDOFcBYoT7PmIo5KQI+kXZLxCmdXl1buYU1eqbV3
	mC0wPPre2oNy9aRXQ6RLNfcCZR7d1yXZGsljNDfw3EoFnoLIgZjMKqrNpwRIsKUJNlJSfMcJOB0
	UHY7xz175i0lmG2b
X-Google-Smtp-Source: AGHT+IHg+gM4oKiJxkneoZZSEiuJLF3jRlkp8J7IlrG19D10gQwMUws/8drOd5JJkeRTb62lPuEMoQ==
X-Received: by 2002:a05:6402:5241:b0:5e0:7d70:bc73 with SMTP id 4fb4d7f45d1cf-5e0b634dcd6mr12478881a12.13.1740413161642;
        Mon, 24 Feb 2025 08:06:01 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e02ebeaaa1sm15644021a12.5.2025.02.24.08.05.59
        for <linux-perf-users@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 08:06:00 -0800 (PST)
Date: Mon, 24 Feb 2025 08:05:57 -0800
From: Breno Leitao <leitao@debian.org>
To: linux-perf-users@vger.kernel.org
Subject: Internal error while annotating function
Message-ID: <20250224-accurate-pigeon-of-adventure-386dcd@leitao>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I am trying to run annotate a perf function on aarch64, and it returns
an error. How do I get the logs for what is happening?

Here is what I see, in either `perf top` or `perf report`:

1) Open the TUI
2) Get on top of a specific hot function. Not all of them reproduce the
   error. For instance, one of these functions is `finish_task_switch`
3) Press "Annotate finish_task_switch"
4) Got the following error:

	┌─Error:──────────────────────────────┐
	│Couldn't annotate finish_task_switch:│
	│Internal error: Invalid -1 error code│
	│                                     │
	│                                     │
	│Press any key...                     │
	└─────────────────────────────────────┘

At the bottom I also see:

	Error running objdump  --start-address=0xffff800080907fa0 --stop-address=0xffff800080908220  -d --no-show-raw-insn -S      -C "$1"

If I try to run this manually, I see the following. Is this the real
cause?

	# objdump  --start-address=0xffff800080907fa0 --stop-address=0xffff800080908220  -d --no-show-raw-insn -S -C /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da

	objdump: /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: unknown type [0x13] section `.relr.dyn'
	objdump: /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: unknown type [0x13] section `.relr.dyn'
	/boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da:     file format elf64-little
	objdump: can't disassemble for architecture UNKNOWN!

The file seems to be a valid aarch64 binary:

	$ file /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
	/boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: symbolic link to /lib/modules/6.13.2-0_fbk0_rc8_0_g925d379822da/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
	$ file /lib/modules/6.13.2-0_fbk0_rc8_0_g925d379822da/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
	/lib/modules/6.13.2-0_fbk0_rc8_0_g925d379822da/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), statically linked, BuildID[sha1]=be549c9fd62405a10f6b36236610cd6a57a6d3e3, with debug_info, not stripped

Any clue how to investigate this further?

Thanks
--breno
