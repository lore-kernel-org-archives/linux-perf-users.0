Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADDC17B401
	for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 12:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731502623; cv=none; b=KYHWw5wIzhNh5G5vuqecS8M2Ao7T32Ws47Lalk337vxyslNiVGAJ++w24AVAqkE23MXPII91GTclAfch/RgXTnu73Q26ty6ia2Up30GqYDcFt3XWy4xLcJ5WiRoYcH29ftazNl9cCnye8CCUVzOxX998rsyc5OWXbxqIWYD0D/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731502623; c=relaxed/simple;
	bh=nsF9FYO1giL4pYCMxHeNqsfHL3n45+fIAA7Zs0xLiDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oee7FAIGyAJXkSEuiw1ENfGQZvX0kGUGJib4oARlpZpZBSTSWoyGfSyTnQfphvWZgU1EMND2ZULUmqoAmZMAh9JX+LND4xUix3fZugouqRwDgPqXWdEjOX5s85BK6FcaNhf4UYrDhIlAj+WyA3wGgmd1KAoQwKi7qpf04coGpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GCs1D/bh; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GCs1D/bh"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539eb97f26aso6738869e87.2
        for <linux-perf-users@vger.kernel.org>; Wed, 13 Nov 2024 04:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731502616; x=1732107416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nsF9FYO1giL4pYCMxHeNqsfHL3n45+fIAA7Zs0xLiDc=;
        b=GCs1D/bh9c34xBvgDRh6x6a9Rzyj6ZOJPxezWwDd0sJOM7p80eJTuAGhhf60XBbePd
         aJlwM+7PvBoLJ3T8AeJeX6M51zyDM+L3gXdB0JVwE1ACFUKqe6bsHNE5wMjtW5RmPze4
         4ayAWbQgzGAcwTXplOfo91sLVPGnJc6qNxideFXpH5hAIk1D/vi3ovpWEaDBGNoiZoKI
         xbDQ0HFTCqwOZmZWjCkuNsbO4lt/er9avMztXRB2kkLSI9aw5yYhFE9Vdivht+9OX1We
         MojbI4skzzDgHhB6B8RrkuLWKXSlxRi2KoGP+atNzj6Z9RDeRpr+ygBpRtXppC21PAkr
         7KCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731502616; x=1732107416;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsF9FYO1giL4pYCMxHeNqsfHL3n45+fIAA7Zs0xLiDc=;
        b=o90bBeeGs+gVLlclzQPkcP4MNSPuLfxyHgYqNPNdmxklhtCVTqgQO5ppe0tNWFXS12
         lSAHFf6VpmnKVsrVveTTmACevimaMCC7d+jBIXYF5dio/tLkk8KcMEF/HWv/sM+XFUYv
         /lvYHpHUDcV+4RWOplHDFKKFTGUPxQvqZzoPdIb74qqqesqlnd3MzvyP6fC+iq1w2oOR
         YGfxsVd5Kf43D3oHMYVzaKGc+qA2DJWe8gQ2XMyCF23TcqFqrg3u5o0n7O7AwVGNE+Ye
         JTQAzYBi74Yc5bp4Ho/+TO+tROtW3zGyyVnoCpwBCOO3i17/rOhKEDnzF11uMchuvSLo
         ZcuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHPZrdQ17clh7IRIsFWEleLXbO17kQJ6r6+qsAVO7zY/iNT3BDaXRgauj3nvTkupm5hZbrYmenhI1UVbz5QRfc@vger.kernel.org
X-Gm-Message-State: AOJu0YzCrnIf/HX18D+A5W5SUuR6pNGaS4tETUamwT+qVfXo0PMBA1ky
	0pZQumWbYU8TKtvNiTGIawVlKg8fB9/JVWOdGixrzy41VMa2J9BRoN8aUcnwQA==
X-Google-Smtp-Source: AGHT+IFE3azi6MEspsez/YqVpfltyfERpgY8sGasO9+OXOeFNj/tcHahdw28SQ3NLTe9e4vnUTpPeA==
X-Received: by 2002:a05:6512:118a:b0:539:f807:ada5 with SMTP id 2adb3069b0e04-53d9a406ff4mr4258046e87.3.1731502615698;
        Wed, 13 Nov 2024 04:56:55 -0800 (PST)
Received: from google.com ([2a00:79e0:18:10:2ee5:f43:b1e7:9d47])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53d826a7127sm2196125e87.149.2024.11.13.04.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 04:56:54 -0800 (PST)
Date: Wed, 13 Nov 2024 13:56:49 +0100
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
Message-ID: <ZzSiEXgijZXkhIoP@google.com>
References: <20241111151734.1018476-1-acme@kernel.org>
 <20241111151734.1018476-4-acme@kernel.org>
 <CAP-5=fW7teKmRfGtjkvk1=PArt7M-v=CBF2EjdY0SbgdU6DtqQ@mail.gmail.com>
 <ZzI90g83cGIKSUDu@x1>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZzI90g83cGIKSUDu@x1>

On Mon, Nov 11, 2024 at 02:24:34PM -0300, Arnaldo Carvalho de Melo wrote:
> On my todo list, and here Steinar could help, is to check if we an have
> source code intermixed with the llvm based disassembler, like we have
> with the objdump based one.

I am no LLVM expert; the only time I ever touched it was for perf :-)

TBH I'm not entirely sure what functionality this is, though; I don't
think I've ever gotten perf to list source code for me, ever (in the ~15
years I've used it). I can give --line-numbers (and optionally --inlines)
to objdump and then look up the line numbers by hand with an editor,
but the actual source? Is there some way perf can attribute the samples
back to individual source code lines the way some other profilers can
(i.e., showing the source instead of instructions)?

I would assume that LLVM has some way of outputting line numbers
(presumably by parsing debug information), since llvm-objdump supports
--line-numbers, but that's perhaps not what you're asking about?

/* Steinar */
