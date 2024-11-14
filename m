Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6DB91EB9FD
	for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 09:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731576471; cv=none; b=oz3ITkEPE/SNiGMqoux1CLIV/u5X/BBJ4GL65iiNlK1B/+Xg8L1aPYz/d6/nfHQbt1AJN/LIVHsioN2b3LDLa7ebDxyEeKAJfAxF6bfOK/bb+MFGSfUpNFNFrrwz1T3G1eFOadBKATC3dghutJ8vzUWN0pekSSCHR3iz9aAQJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731576471; c=relaxed/simple;
	bh=ujXkAz4mC8eFae8g5t163fNJfEncieh1V8wdDnl/jWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8U3F4qUXvbF3JNWn6IaSBD09A8+YlL/WL5tttS927xwGGOJy/aW7ijEJkEwoVNHxx2aJw20CNIETY6z1Dnv/YUzrgxUsOgS0dL6HedMJlE+7Bh7Y8+JZG/ilVPMFGTGbOiSCUblb0zalT1M01NFhjHVfcIkrwGm0n8Wo8yYCUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G5EIOpGj; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G5EIOpGj"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53d9ff8f1e4so369617e87.2
        for <linux-perf-users@vger.kernel.org>; Thu, 14 Nov 2024 01:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731576468; x=1732181268; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tq/XRI940eBi2hk73EX1Uih0B9Ig4u+u6Up8x85IdIU=;
        b=G5EIOpGjCG/41qoFPRMwoILFSSoQmWMiqblRQaeHX41FqYqFMef3bxfDbfElBgWKnI
         rglWnMmClxtPgLyZBu//NZnU9zVrXuOIUO7TI1zcOavIn/bYnqRSpbMfcRhGguJadinj
         ZA+RRpo+3sNqdr1nS86S/pSGBNvv9+ix3RfuL/7XpL/Gtyf8MYECaqzxbkqEiLuG8JyF
         fGxTjA9y7s4c+8nBPXkURFYh4FZdnQir6XVSsSEE8MSvniYHNbNOGEgEf+feiyFBTBbP
         0jAANkqId5mAtOBJTBb31swNbz4UyMZCPHYNqtGA9qCgS/+wPIRwtNi77Wt5kLkm3IDz
         ktQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731576468; x=1732181268;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tq/XRI940eBi2hk73EX1Uih0B9Ig4u+u6Up8x85IdIU=;
        b=pe/FEcJkkn0wfnxPQj43PVucLSD6NZNL6PrvFaY+btI11+dFhixr6/4HBqDwb95W4F
         25KVo88xICa1PP4on8aEeVbrXxKhpVDvqy32Y99M6ckM0+2BCAnVmLI2DLCgINvpCP4s
         Fp+X60pf1x1J+PidINEoP9DipFKIR2oc+q5ZvpGxudbkRlNYtKGg243kR7jFjsLBHrAN
         O7n4LYyoLxryXuJXLjTFiBBgKI85Swc60CkKmPBIK+HI3QUU54caczeRGpErtpu/1qEG
         WQj+8+DH06jZnPO9DqZub9JzGfIKS4vJ4fMunDOG4cURIkOhE3gyQNPP3eyqKRya/6jE
         Mz7w==
X-Forwarded-Encrypted: i=1; AJvYcCWDUL4ufyOJhUd1VK8A9TDlmdd7xRMDo4UUOZGMCEIow4jbine+3rS3zj2FSI0yHYMdlmgEQgYE7j773a6BzWEY@vger.kernel.org
X-Gm-Message-State: AOJu0YzV+h+BbzZvLFIzP4OuJuhgnXxMfBEyVt9i91t05Hv9piPxWlRq
	56+n01jizXe56zgmElZEMUmEnS4CNIeS172zF949m06ucK8W0JvZHYpI9Ns0eg==
X-Google-Smtp-Source: AGHT+IG1la6K1cY7jFPT3YBqPV/SUwY/alI7LxaKIjO/GRx2//v2F8HA676xWPGQaFYUqy0OpPLkDg==
X-Received: by 2002:a05:6512:2387:b0:539:8bc6:694a with SMTP id 2adb3069b0e04-53da5c776aamr660206e87.43.1731576467542;
        Thu, 14 Nov 2024 01:27:47 -0800 (PST)
Received: from google.com ([2a00:79e0:18:10:f492:7c34:9c2a:c5ee])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53da653e1edsm118878e87.183.2024.11.14.01.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 01:27:45 -0800 (PST)
Date: Thu, 14 Nov 2024 10:27:39 +0100
From: "Steinar H. Gunderson" <sesse@google.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Namhyung Kim <namhyung@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/3] perf disasm: Allow configuring what disassemblers to
 use
Message-ID: <ZzXCiwDSqCMzaA17@google.com>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-4-acme@kernel.org>
 <CAP-5=fW7teKmRfGtjkvk1=PArt7M-v=CBF2EjdY0SbgdU6DtqQ@mail.gmail.com>
 <ZzI90g83cGIKSUDu@x1>
 <ZzSiEXgijZXkhIoP@google.com>
 <ZzT6fjDSUlPzUt0U@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzT6fjDSUlPzUt0U@x1>

On Wed, Nov 13, 2024 at 04:14:06PM -0300, Arnaldo Carvalho de Melo wrote:
> So, source code, automatically obtained from a debuginfod server and
> places where one can put a probe.

Mm, OK. Unfortunately I don't have any debuginfod stuff available on
this side, but I understand the desire.

I looked at the LLVM disassembler and it _does_ insert line numbers:

                  llvm_addr2line(filename, pc, &args->fileloc,
                                 (unsigned int *)&args->line_nr, false, NULL);

But this is maybe not enough? We don't have any machinery in perf to get
from the file + line number to the source ourselves? (What does capstone and
the embedded binutils disassembler do?)

> You can show just instructions or instructions + source code.
> 
> There were requests but no attempt that I know of of doing just source
> code.

TBH I'd love the latter, but I'm not going to sign up for doing it. :-)

/* Steinar */
