Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E09268C7D
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 15:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740497257; cv=none; b=kVqUM4zJE0f1WepOsp+MFaTJOx51q1dTavn+ptr2V+UB1uU6/ESdRgF/RQBW7aofHB8Csw0Ae2Hy5142ZcdtPXom2+AwTme0+FMbL+LTamwiVrdvL84AH2yKXmziRLDVd3uwqajs/0O2Jh7AStut/pG4dJ881vW+1ec9xbzKa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740497257; c=relaxed/simple;
	bh=02h7XBHicZ5/CvrIXsyNhKk5HHVaWiADJgctR4CRH4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCUsGnF0ulL2gmjtiQyOd2GmcYrLIeYheppPN+a+9knhL0mW5HcnCI8imECUcHDwRLuOyICKXmc1qld+ObaWx8aKG7r+f7ffD+7rlPcMT6sMB4OSubD0BaMvMlWul9XPUJ3JRXqebGCgJkLPfxXTDlMxDqGi4zfiUSB2DeJN0wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38f22fe889aso5104607f8f.3
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 07:27:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740497254; x=1741102054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sv1VHTi9BDPUHHkedIfWchhukQqkwvAvj4LERlbZ43A=;
        b=M5B8eqR9xRBw7MmnIu9Eik6oymzcoaqzZGNusFOQX8AvMNmCAEGyEmxuLcgA71A0SZ
         XbxE/bKbnMXRDBXzNk2Y2oxUqh0/Ivh3s7gC+ZPo2AduVrogGRbG3pcPsO7H0O9LzvU9
         MwkqrglNbush09n2QzVu0gQY5KBtLAIhJDftMU5Z8IlemOj5nM5prcj3qr9pCRqLZOyy
         6Z5X2mdU8BD1I1iWtsDRdNVKBpAyE7lILm1FAmcqI5EvxSKZcjcnnEoitZpRdijkouRE
         yBfNuN1GRuWzNFZtyq3Qhi+8vK5xLOGfv309ywfSJRchZuT8e+6NsPwCiYLcaJ6tDdms
         KNZw==
X-Gm-Message-State: AOJu0Yz+bnAqza6nHLGqODH79AQ7NCkWJA3DLWwFQvNBzGSKeGfrE0WD
	5Clw+8Vmbxc4fUq+lDj3LQMAt1IodmI6ubDITgdSkgt3nlgcDUrmZJW6XA==
X-Gm-Gg: ASbGncuiDL+81vI8UtLg4+9nBXQfshsvkPgR2eTj/TENtGbf4Bg4keDN2p+7eKsMfR0
	zCcBcDV5kE6ldbC+SQqmMsDJ/2zf8SRhkMQICPSNt/K2vTe3VpnD6izEeuEhLYxUTHuhOCB9flN
	Z0OxXgPclfo+acpLnd/1jFz6KplwtC/wpnygng/Uy3HOG9RMv+pPeLn/r5TWieYVmh59O3kUBNP
	WPwYMKnWYi17W0oJuKX3UQsSyf8axImZES68YMKvV7FvV22frgdsddeiXNY2qttjpo+0oSE9zr8
	UiJJe851z9UJcg==
X-Google-Smtp-Source: AGHT+IGo2+lAxqiqmn7MoB1tOsX0UJqglaPro4NocmO9RMacADAhNw0iwjdOb6/lumhp4iJrlfTIiQ==
X-Received: by 2002:a5d:6d0b:0:b0:38d:c56e:f1dd with SMTP id ffacd0b85a97d-390cc6319e6mr4865682f8f.38.1740497253745;
        Tue, 25 Feb 2025 07:27:33 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed2054d7esm157769666b.136.2025.02.25.07.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 07:27:33 -0800 (PST)
Date: Tue, 25 Feb 2025 07:27:31 -0800
From: Breno Leitao <leitao@debian.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: Internal error while annotating function
Message-ID: <20250225-shapeless-calculating-dalmatian-f5fcac@leitao>
References: <20250224-accurate-pigeon-of-adventure-386dcd@leitao>
 <Z70KqrJXaVcIq8qh@google.com>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z70KqrJXaVcIq8qh@google.com>

On Mon, Feb 24, 2025 at 04:11:22PM -0800, Namhyung Kim wrote:
> Hello,
> 
> On Mon, Feb 24, 2025 at 08:05:57AM -0800, Breno Leitao wrote:
> > Hello,
> > 
> > I am trying to run annotate a perf function on aarch64, and it returns
> > an error. How do I get the logs for what is happening?
> > 
> > Here is what I see, in either `perf top` or `perf report`:
> > 
> > 1) Open the TUI
> > 2) Get on top of a specific hot function. Not all of them reproduce the
> >    error. For instance, one of these functions is `finish_task_switch`
> > 3) Press "Annotate finish_task_switch"
> > 4) Got the following error:
> > 
> > 	┌─Error:──────────────────────────────┐
> > 	│Couldn't annotate finish_task_switch:│
> > 	│Internal error: Invalid -1 error code│
> > 	│                                     │
> > 	│                                     │
> > 	│Press any key...                     │
> > 	└─────────────────────────────────────┘
> > 
> > At the bottom I also see:
> > 
> > 	Error running objdump  --start-address=0xffff800080907fa0 --stop-address=0xffff800080908220  -d --no-show-raw-insn -S      -C "$1"
> > 
> > If I try to run this manually, I see the following. Is this the real
> > cause?
> > 
> > 	# objdump  --start-address=0xffff800080907fa0 --stop-address=0xffff800080908220  -d --no-show-raw-insn -S -C /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
> > 
> > 	objdump: /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: unknown type [0x13] section `.relr.dyn'
> > 	objdump: /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: unknown type [0x13] section `.relr.dyn'
> > 	/boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da:     file format elf64-little
> > 	objdump: can't disassemble for architecture UNKNOWN!
> > 
> > The file seems to be a valid aarch64 binary:
> > 
> > 	$ file /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
> > 	/boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: symbolic link to /lib/modules/6.13.2-0_fbk0_rc8_0_g925d379822da/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
> > 	$ file /lib/modules/6.13.2-0_fbk0_rc8_0_g925d379822da/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
> > 	/lib/modules/6.13.2-0_fbk0_rc8_0_g925d379822da/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), statically linked, BuildID[sha1]=be549c9fd62405a10f6b36236610cd6a57a6d3e3, with debug_info, not stripped
> > 
> > Any clue how to investigate this further?
> 
> What's the version of binutils?  Is it old?  I don't know what's the
> problem but checking the latest version might help.

I've been using the objdump from CentOS 10:

	# objdump --version
	GNU objdump (GNU Binutils) 2.37

I tried to use a different objdump (as in llvm objdump) and it worked
fine. So, it seems to be an objdump issue:

	perf top --objdump $(which llvm-objdump)
