Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34F336D
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 00:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740442284; cv=none; b=CBBo5UuPTS/YTDLcqQv/H8PY566ZSPxRnViWgyvgkvLNbmp4nzrOOY4sAVtz+zf7aUmxIgvw8TEPb0IKFaBLw5wpjHNKlRfolm0pfyQTHcIMcE4iJ2G7FcL/yXhcQi/fgQtdJAnM4EPE3if08pQSDpHuS0Gi7aLIZZkkT512wFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740442284; c=relaxed/simple;
	bh=JaskOpoRxDD8dcjhSVRdXSxxLXdFlbvfueQQezwalOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ERhr56nZ4LGoh6s2rlzjtmOAHqfdK4V71P/a+/miKXebJlQl8RSogS/DMhTqvff8xzS7IMZaMeIhVxnf5gId3+RQrBLppbXyJWZmq1IL8cwNabWIVtISdyFyEgjcztx0+91YHCFc+jsBqA88PbmRZ8bZGzh363OrnfzX7n8ULxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ve/GNrSd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ve/GNrSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE82C4CED6;
	Tue, 25 Feb 2025 00:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740442284;
	bh=JaskOpoRxDD8dcjhSVRdXSxxLXdFlbvfueQQezwalOs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ve/GNrSdF3izGyWkZ6boNR7ceZTRnsUXq7IK+Rt7ZFxV6xBXktBGtZgUDf3kpf0IP
	 75WdCkZxLoplwa/dSgQSNurY6tS3zLUlLab7AvvLcv22M60d34LmyliuX5ORRwisZH
	 B87NP2w7mBlFbnlpNs45UbiTm6XR07WIttBRymOn/cXA9k8YIA1ZFWKoHgHkhhnarT
	 5q1WSsnzkHSZXGgQII0nFby+40V+iDpQ8V3rqtGpjPo2T5SgDe2hoiGRkHkN0LnBYP
	 GYm+1ZYJV10ZBGLDp+aCTrZ2qTYgQ6FnXdqZnEsAZyEJYechsRtzSrkjd4DyH64UIj
	 6ghfe659z2KIg==
Date: Mon, 24 Feb 2025 16:11:22 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: linux-perf-users@vger.kernel.org
Subject: Re: Internal error while annotating function
Message-ID: <Z70KqrJXaVcIq8qh@google.com>
References: <20250224-accurate-pigeon-of-adventure-386dcd@leitao>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250224-accurate-pigeon-of-adventure-386dcd@leitao>

Hello,

On Mon, Feb 24, 2025 at 08:05:57AM -0800, Breno Leitao wrote:
> Hello,
> 
> I am trying to run annotate a perf function on aarch64, and it returns
> an error. How do I get the logs for what is happening?
> 
> Here is what I see, in either `perf top` or `perf report`:
> 
> 1) Open the TUI
> 2) Get on top of a specific hot function. Not all of them reproduce the
>    error. For instance, one of these functions is `finish_task_switch`
> 3) Press "Annotate finish_task_switch"
> 4) Got the following error:
> 
> 	┌─Error:──────────────────────────────┐
> 	│Couldn't annotate finish_task_switch:│
> 	│Internal error: Invalid -1 error code│
> 	│                                     │
> 	│                                     │
> 	│Press any key...                     │
> 	└─────────────────────────────────────┘
> 
> At the bottom I also see:
> 
> 	Error running objdump  --start-address=0xffff800080907fa0 --stop-address=0xffff800080908220  -d --no-show-raw-insn -S      -C "$1"
> 
> If I try to run this manually, I see the following. Is this the real
> cause?
> 
> 	# objdump  --start-address=0xffff800080907fa0 --stop-address=0xffff800080908220  -d --no-show-raw-insn -S -C /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
> 
> 	objdump: /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: unknown type [0x13] section `.relr.dyn'
> 	objdump: /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: unknown type [0x13] section `.relr.dyn'
> 	/boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da:     file format elf64-little
> 	objdump: can't disassemble for architecture UNKNOWN!
> 
> The file seems to be a valid aarch64 binary:
> 
> 	$ file /boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
> 	/boot/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: symbolic link to /lib/modules/6.13.2-0_fbk0_rc8_0_g925d379822da/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
> 	$ file /lib/modules/6.13.2-0_fbk0_rc8_0_g925d379822da/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da
> 	/lib/modules/6.13.2-0_fbk0_rc8_0_g925d379822da/vmlinux-6.13.2-0_fbk0_rc8_0_g925d379822da: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), statically linked, BuildID[sha1]=be549c9fd62405a10f6b36236610cd6a57a6d3e3, with debug_info, not stripped
> 
> Any clue how to investigate this further?

What's the version of binutils?  Is it old?  I don't know what's the
problem but checking the latest version might help.

Thanks,
Namhyung

