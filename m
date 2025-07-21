Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBF419CC28;
	Mon, 21 Jul 2025 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753076432; cv=none; b=cwUCCXUArmh+6Lma0+2LtUP6L2ALIShbWYssYkw50RLDZvpU7jTi7l/nifEU19xaoj3fomU7N7I2yb3ytc5fvU5cpcR6tiUqJ1wLiL24chhfbAV0SchyDmax8zbu3v+ofnqoHBDtssXMYXlIe1BdtSBuoKmZizTbYz4zs68djrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753076432; c=relaxed/simple;
	bh=iX+q2jNSRCnOrj9thY+MottftiVMIhrYnrO3+IHfSHA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNaT4JSO42jx+w3O+WNLGaWPqTpFafINT2+a1P8t3DwsTKPZaBCAba350lATQantxot84MYEoLLn9SbXikfGz3v9YrTz0fUnCUiJs124vUKpuS49lfU2X6l0Xw4IS5AfTE/2ycWpUHxKvJBGOU75FsXxZt/9IvIjXpSC5i+8W98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GQPXm2On; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GQPXm2On"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-615e56591aeso114362eaf.2;
        Sun, 20 Jul 2025 22:40:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753076430; x=1753681230; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iX+q2jNSRCnOrj9thY+MottftiVMIhrYnrO3+IHfSHA=;
        b=GQPXm2OnzAcpotN/UVhP6f7u6blt4fZv5GROQPF/knKIw+dunYpzyLoM5DXJnTEOqZ
         osD0o1nXhSB/zbKjCwBkshN4dYn+i9VSD9hr3ziW7nKAf649ITGITGk0HX/Fj2vil9A3
         U117pVCT6Ma5JSQ9/+/mFFjVDPr9uIluVeFU+0wpCHYwrkoJnaAtXCjBsPj62D6psQ2K
         /gxUFw9JKQZTZTSJPuFqmnKJcZlgUev3IptSHUuEn7RKFeU+9DEuhrGShl7m6qo8Fyrv
         lRIKa+X2bdxnLYTBcIPg4lp39vQ8amWiwr3DzrNQGPWOVUoesex9O1Ddsa7Exsg7Y3vU
         ZNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753076430; x=1753681230;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iX+q2jNSRCnOrj9thY+MottftiVMIhrYnrO3+IHfSHA=;
        b=ZNf5DWG7wP8Q9fCIAWjjqSpTISZLWpWSncAABRGmlKwhBUHhv3dPBxAY4bNlHDhLZs
         AdB8kqoMNdcHYoyBMNh3QpUe/yiMmQHRuipLcDIY9C0wVeDdy8Fs5oeRy80GjQxUFqSV
         BCD83HUqqACRSMvBCqIbZE8HrorBiSuqK7odZDQai6k7QA/0nKhc0gPe6INnDmuAnFJO
         26L4f3QEFgXLFiflSQchFqMU2kFO7ifTZPwMLT0jLO05HljgSDYfEVqR8VH6zyOvq/jT
         IC+sIKQDi28noQcq9zpdnO0lUQaBcuuTjY//NuBUn92xjTGBZbFcUxOyQ6EYeD0QjuAO
         blYA==
X-Forwarded-Encrypted: i=1; AJvYcCVampGQJURYrMB1tp3FuD6g2qcbmIPOXFoIq9MZHYq9oxRgyH9BLs+xCYGCPJHUJro1xyE+m15fPfCAGP+T1daUdw==@vger.kernel.org, AJvYcCWMd8zPQiQYuVwEVZqaPJmmHgj4cKX7g93h4UqGjqtryR7ORAc1pC+R3dr7rJqBFenqJCfiRW/BZPLJ3+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP9Q0WcbjS1bDHdclktCHz6duLTDcffhZRCK+ujswgYmVlNnxZ
	mPNkUodIr5cWeJRZ04AsmXui5kXoh/SPm/mUuyeXSKulJ8/R0ROAoWe10T49OYscWLG3FckIrWG
	0v/xxkw9v8vTVwHb44wEFbLG/x/04TsE=
X-Gm-Gg: ASbGncthNkszUfuNvYLrLz9MUCgDVKfZFdVhjNPpDjDgkNmwMef1RJbFpdF3AwEl6xA
	TNNvJzpr39HDwUiWqlNuMS37ezOTgL+Vq8Oh8/NNxle3E3ifsjxvpfjnflba3j0Dvhh2SxgSlI3
	5VBn9yjToh3d50/ZYxLoAfv1R9h+GArx7hlgua9x2kLLRXGa1ltKxXLtKCxn08ivstg1Eb/Pm9Q
	wJ1voNiAW1O1GvpN2AJbQxCU2ojH8l7vdbuHndO
X-Google-Smtp-Source: AGHT+IGVDW5DwgDPsxtNTio877e0JtvRpQ41q5Aw4TFpzMaMt/rN9gSbqjnLe52enOAAAhcl6uV1/ExSkCOJ9+m5z0k=
X-Received: by 2002:a05:6870:f60f:b0:2ff:96c6:f712 with SMTP id
 586e51a60fabf-2ffaf53f5d7mr15591342fac.26.1753076429897; Sun, 20 Jul 2025
 22:40:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250720085905.192652-1-suchitkarunakaran@gmail.com> <aH20-KEurjw5qJq0@google.com>
In-Reply-To: <aH20-KEurjw5qJq0@google.com>
From: Suchit K <suchitkarunakaran@gmail.com>
Date: Mon, 21 Jul 2025 11:10:18 +0530
X-Gm-Features: Ac12FXwqf-5IcxmRRFhweSopLncsfbo1HAHsMQAomXOzJCIeeRuDKPaBaCleM8I
Message-ID: <CAO9wTFhdgHEFQDVt2715qP6-6bsE9+AeAAPYe4C8N1mqpy7g=Q@mail.gmail.com>
Subject: Re: [PATCH] perf tests: Fix lib path detection for non-x86 architectures
To: Namhyung Kim <namhyung@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	linux-perf-users@vger.kernel.org, sesse@google.com, charlie@rivosinc.com, 
	linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev, 
	skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

>
> A dummy question: Does all other architectures have lib64 vs lib
> separation?
>

I had assumed there would always be symlinks, but thanks for pointing
that out. After your question, I checked various architectures like
x86, ARM, SPARC, s390x, etc and only x86 had both lib and lib64 (with
symlinks). On the others, even for 64-bit systems, only a lib
directory existed. I also realized this behavior seems to depend on
the distro. For example, multiarch distros like Debian use separate
directories for lib32 and lib64, and a lib symlink pointing to
/usr/lib. On the other hand, Arch Linux has both lib and lib64 as
symlinks to /usr/lib. Would it be reasonable if we create a symlink
named lib64 for non-x86 architectures? I'd appreciate your thoughts on
this. Thanks!
