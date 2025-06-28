Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CF586323;
	Sat, 28 Jun 2025 03:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081706; cv=none; b=Dz9bQESAT+MHy2BpLK1NIYBD5HIytP1FhwMB8oXZIJ9G+0Ubp0nAmuVnfUbkEeTOKsUhCRhHvv4cV8ly7PgtLnYGGlbD3QIQ/LRpkp/FWEHZOzO2IM2uEjEuFPp1wGzo7Xi+SwpwWVj1ZBeAr1BXqfPOwydLbkJ/c4G0+ab91wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081706; c=relaxed/simple;
	bh=Xn2sXn2aR/SBlJAzgqOBwVUmeTL/PPuCDmJupZmSvb8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TfTx4TqCLQ9ukY0/06bLYfhA42JvImavDwsapT2syqQTtOnpEtfqzgHQDzMZZfV1w/n2yGT+JOpIOBFfnvoIz5Odwbpnt7pSivIykEiPal0/HbVuoreKvNRAHXEHkQ/gFXg7PfGFXTSg/C3Nn1LXtmh5e6El9Z/3oQQ4d/K+0Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EKEaPqhV; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKEaPqhV"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-236192f8770so18810895ad.0;
        Fri, 27 Jun 2025 20:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751081705; x=1751686505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7ormnE8Q8M/15d4H56JDCz0POSaIYv5nAxy7gw172Q=;
        b=EKEaPqhVHj1zqViy1QQRrJbBiuUzSxYeKAcXMQmzVDRe7Rn9CBdazcELC2W2uBOFZz
         Jmq85BukB6iFjmddl118at1N3eSJtfIWf+iYSzQ94tO3MOxNaCKFoPlf/MenOT44SGKZ
         IjRV8E07y9/ZemEKhVPvzvKKMCSr+iSgjSOSdrLE2S9hdg70LQjjk5D1Va/DnQsxketc
         LtoW12OqUHpbLjy5ii/KwLJYV7akPS8bXi+C3LqMwdPtDQanO+gb8E6knDty9XBjSbHO
         gPdDvLO4Nuzr8LkEZZE8d6m9atS3ReyCtkAttFqIpnEWo3UcnwWSehUcNTA10pNY+YTV
         I0dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751081705; x=1751686505;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C7ormnE8Q8M/15d4H56JDCz0POSaIYv5nAxy7gw172Q=;
        b=dhVFcrgegzzUxOlDHz8Qb+BBQICW6We4ZQFCbOaZI0REjTxldV/KfJO75RATrX24Q5
         mW8w4I2n4FTXYgRaiwRZXBSfpKzHCCRIgGOJOMW1IFW+7CyrpcntHyaUIcWLdWopqXJZ
         4H8JpMp5I5iE7aBz/xrJ0q7m7CCI5F3CPyd32xA+lpIZeIkqlwZYfFlJndxfzpUGXGdQ
         dOwbzocaNMUKiCsxytX/hH7jr6BJPx7swYyX12w0yXwSY82CmEPdfZzw16fY/3AqUAeN
         7VSoa8blvhSU9mQS0ROArMrM86VvOxJVvOt/1rC9wmo3MbAiGdqfkeFcSvSxBbSJ8iXu
         PmzQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBu338rVs4zIeFMQGPDYKd0odAXyP1HllSwZAm5AAWlALMakGioCyg1GBWIko0Wak8J8F98O4ITcjV7MwlIaDlFQ==@vger.kernel.org, AJvYcCWa1kbdTy0iHG/mj0Tu3XWNWc8H9VS7j4bxMRlMchXilubaOkYDjg5R9rjw3OTioG4bBoMqj2T1bfXjg4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrQuCpg5dtZIwUzA+duu1PlUi8+8g+VhrXJ9OJdBLlvbr4xkhD
	KDvfUXoZ5urRXZhAJw+LQoNVphCZIYPOfH9UYewN4B+gQQ+ptnBJMx8SSVPL+FQu
X-Gm-Gg: ASbGncvAnJIuGPTTxdgd4Z4OQU2sUDsYDplv7K0M6V0bDpDirGuu2/ZdYgAg8wk/URE
	7FIMrie+NTrNBu0Fe3qLxaKPhlKVS6BCD+Dh4IH8wEraoF65cYsK4LCIaTkU6o6Jd6eXwuDJnXR
	0vx7oHxyqr0vNZRQXvc4hhPBDz4PArVUQQaRYP78R3sQ8Ee4WJ3g7X1vhYNZm1EobTgxmWgb10D
	yWH2zYPXsIV55iRbUbPSakTV9FEhySjHRzIXaV7X1Z4YnuNL70JT88R+JHxrA/imFAA+qXmk+Lg
	/4onEjxQ3rvhOUnfHODPctmtQA/0cNCTVHw8o+wTC3cKstP1vjrkDA==
X-Google-Smtp-Source: AGHT+IFUXX4gVRqr9fC3hnnKiqDr9u1uKGwStDNyA5TW6206H5nI3/yeB38WH2K0RgphGz0RL1eNfg==
X-Received: by 2002:a17:902:d491:b0:234:2d80:36 with SMTP id d9443c01a7336-2390a4a7dbemr153874085ad.14.1751081704740;
        Fri, 27 Jun 2025 20:35:04 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::fd7d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb2e3c27sm29489925ad.51.2025.06.27.20.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 20:35:04 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,  Ingo Molnar <mingo@redhat.com>,
  Arnaldo Carvalho de Melo <acme@kernel.org>,  Alexander Shishkin
 <alexander.shishkin@linux.intel.com>,  Jiri Olsa <jolsa@kernel.org>,  Ian
 Rogers <irogers@google.com>,  Adrian Hunter <adrian.hunter@intel.com>,
  "Liang, Kan" <kan.liang@linux.intel.com>,  James Clark
 <james.clark@linaro.org>,  Charlie Jenkins <charlie@rivosinc.com>,  Ravi
 Bangoria <ravi.bangoria@amd.com>,  "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>,  linux-perf-users@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] perf build: Specify that shellcheck should use the
 bash dialect.
In-Reply-To: <aF2Fx-cYy6B69d4S@google.com>
References: <e3751a74be34bbf3781c4644f518702a7270220b.1749785642.git.collin.funk1@gmail.com>
	<f8415e57c938482668717d918ab566ff5082f281.1750743784.git.collin.funk1@gmail.com>
	<aF2Fx-cYy6B69d4S@google.com>
Date: Fri, 27 Jun 2025 20:35:02 -0700
Message-ID: <87a55sles9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Namhyung,

Namhyung Kim <namhyung@kernel.org> writes:

> This caused a trouble on a test environment where 'which' (and
> 'shellcheck' as well) is not available.  Now it makes SHELLCHECK
> non-empty unconditionally.
>
> So the version check below failed like below:
>
>   make[1]: which: No such file or directory
>   /bin/sh: - : invalid option
>   Usage:	/bin/sh [GNU long option] [option] ...
>   	/bin/sh [GNU long option] [option] script-file ...
>   GNU long options:
>   	--debug
>   	--debugger
>   	--dump-po-strings
>   	--dump-strings
>   	--help
>   	--init-file
>   	--login
>   	--noediting
>   	--noprofile
>   	--norc
>   	--posix
>   	--pretty-print
>   	--rcfile
>   	--rpm-requires
>   	--restricted
>   	--verbose
>   	--version
>   Shell options:
>   	-ilrsD or -c command or -O shopt_option		(invocation only)
>   	-abefhkmnptuvxBCEHPT or -o option
>   expr: syntax error: unexpected argument =E2=80=98060=E2=80=99
>
> And it failed to build later on shellchecks.
>
>     TEST    /build/arch/x86/tests/gen-insn-x86-dat.sh.shellcheck_log
>   /bin/sh: line 1: -s: command not found
>   make[6]: *** [arch/x86/tests/Build:25: /build/arch/x86/tests/gen-insn-x=
86-dat.sh.shellcheck_log] Error 1
>   make[6]: *** Waiting for unfinished jobs....
>
> I think it's better to convert 'which' to 'command -v' (in other places
> too) and add the options after the version check.

Oops, I assumed that on a system without shellcheck NO_SHELLCHECK would
be defined. Let me write another version.

I think the 'command -v' change is best left for a separate patch(s).
Since it is used in many other places, and maybe others will raise
objections.

Collin
