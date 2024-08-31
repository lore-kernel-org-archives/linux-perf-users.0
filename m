Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33684165EEB
	for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725097580; cv=none; b=DwDOGTXtSSRLrZH3uR6DzyUp6pW2S2d7xdy1R05ldxnIwqAXjj4M79Xfcv2kc2BGwlixsGbga07VqfX1KRpfkxav4VPxud0NabdYO7P2Bn8A9l3myc6sLAICtWYB7VUPCBUJTuzHJdh8qGvkWIJ9ZmnsPmgzs0qPb+C8sv9/xE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725097580; c=relaxed/simple;
	bh=H8n+IZh7NDO2lGGGJAq70ToHaH0UAug872TCkp5AB5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AEzBQ5xc18R4oxHKy/FsaIgC8kalIer89e/yadza6imDQ53kkJ05TIDBUt3T5/+3G/RHhDHnlaH+cGM0eHMK/12910utFnWfzUNWAagxrZvhZG1zsimpjZd3sMjBQAWSManO245WlN3ED/NmK1vckFXN1FNd3XdlJW4ZHRT0jeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dD4rvBuU; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dD4rvBuU"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3db3763e924so276844b6e.2
        for <linux-perf-users@vger.kernel.org>; Sat, 31 Aug 2024 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725097578; x=1725702378; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iwT8VsI/OllNWFN75ti2nJT245mIWR2gthEfvHeAWXw=;
        b=dD4rvBuUpO48hmw3GzX1EWRoOtxXqriO2/Rwl4Zt7seo89ksQ+JYSGzmvml3D7Q2pi
         4dQBtvyRTs2+kC2jLAZF/od1S6Wcc5qmylRLLAGjeIf+o/11O8D5MzMHj8WtmxIq6+Lu
         fzk355PkDOV33oQgHdpNO79Rb2rXh/lkifJLluvHVFb2ASg0bwqP62U0tw2c9c/TpzyI
         6pozCZnPVX3Zc+2OeTk4ae91FM+lbkAkaaD5/WD5hDfEWQfom0aouXUBlkRLwdJZbOxZ
         J36lR5/wvh6239Te9EEAf2OYYMTYFAUGV782+9yK4217hN57nRe8r5bqZtMUtbdeOBvm
         rRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725097578; x=1725702378;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iwT8VsI/OllNWFN75ti2nJT245mIWR2gthEfvHeAWXw=;
        b=cmE5M9aKNnva50feMsNeRRk9z7wcFkQHCIybKyWYMkYB6uV4ncmNZ3asgVTDskmPQQ
         MmXMVOPmsbZ2MkOJs9oUElsETNVl9Eq0VCoLp/aHNUpGEAKTkRmjYNRhJIAJk43SkkPy
         d9Ojtwn1HwS4pxoBU4UEifqFz/OP1kfju5M/WJzHVFV5S6KlfmsZTqDZ2UByQF4Tfijq
         t69+x7djy2qW79H1NV2y8zusyOT1isc9W/XNfjXIkF8BcDBJvuRFCRupXex0b+24ctNQ
         /Zp/HeV5ljABvVWzqqtkS9t6xm2bshw81zk2hQPGXMWLflwW6BsSTPQQSbQUJ+FHLknc
         bWjQ==
X-Gm-Message-State: AOJu0YyfhX4+euY5vJI+8HyBuXq8e9o2edvoRj71LwUvizGUi8PInfGY
	Gc0t9lmNkgQnxXH8M32waU2ldv1AyFChSHUR/PwTc9zSRwpsLAio
X-Google-Smtp-Source: AGHT+IGJ/2a3FGQSmKRKubsFygtpzctBI0atBfEDHh1/8TomEEbuEnXos0ykwTUK6dvmxQp209+jgQ==
X-Received: by 2002:a05:6871:520d:b0:270:eb9:e17d with SMTP id 586e51a60fabf-277b0df369fmr2763588fac.8.1725097578007;
        Sat, 31 Aug 2024 02:46:18 -0700 (PDT)
Received: from [192.168.50.95] ([118.32.98.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a45e1sm3948135b3a.58.2024.08.31.02.46.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 31 Aug 2024 02:46:17 -0700 (PDT)
Message-ID: <160b2df1-3838-463f-8365-9c789180a2de@gmail.com>
Date: Sat, 31 Aug 2024 18:46:14 +0900
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: publish: perfwiki.github.io/main
To: Howard Chu <howardchu95@gmail.com>
Cc: linux-perf-users <linux-perf-users@vger.kernel.org>
References: <7f2b1c74-4087-4da4-94eb-51d37f3d8fc2@gmail.com>
 <CAP-5=fVmP0sNaE-T0PAHb0y+Eoo7eNgDFyu7kCT+Hp+G62KXHw@mail.gmail.com>
 <CAH0uvohyjLojJYtwCQeD2zmDYavjYWmom3C4O3Xmou-ez_hCkg@mail.gmail.com>
Content-Language: en-US
From: Yunseong Kim <yskelg@gmail.com>
In-Reply-To: <CAH0uvohyjLojJYtwCQeD2zmDYavjYWmom3C4O3Xmou-ez_hCkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Howard,

> Thank you so much, absolutely amazing work.
> 
> Just sent a pull request to the perfwiki github page for some minor
> improvements, can you please take a look?

Thank you so much for comparing and updating the main page!

Your pull request was the first one for perf wiki mkdocs version, thank you for updating the documentation!
Link: https://github.com/perfwiki/main/pull/5

> Cool.
> 
> Thanks,
> Howard

Best regards,
Yunseong Kim
