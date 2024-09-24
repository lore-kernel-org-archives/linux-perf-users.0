Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEED154C03
	for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 09:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169504; cv=none; b=F6Lt9DVhHoHWLNvaxaCVwvTEP5qHloFMnF2sgTUGbwAEg5oYOZ9mPB1oP8YqLbrbZr75aoNeD/PycDD+rKabFedupQUG9RBkiKF0cfdtjcCW/zYUp7UgzSB/id9bqziszOivmxgXRemXxxyIzRwKkbjta6JLeqh5Dj4B/KJCHlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169504; c=relaxed/simple;
	bh=eQAClSjxybBfQuWFY9v9ZtzZlS3Vjk2Oap0J7f8u4T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=ZPudfrQ8sFxVvkwq1D5ZOfZ2zWavorJyLP50HI0HRpNCiDfsbsPJkyP/EfsmVdwqbvAzc61V2XqXmv7LvwWrbvw1dVQvVWQGIRqZdT319/wOd93hZXDrDvWNCqon+etQKRALDe3yqt6WVkjS/bgIeibd6GLOrlVy0RWMPXKLhI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AEVumfp/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AEVumfp/"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a8a7cdfdd80so749379966b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 24 Sep 2024 02:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727169500; x=1727774300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8EoVKFjbfi+a6s+4sCHipQc1F1mmCzYoxrqTTZyTQIE=;
        b=AEVumfp/+Tw2s9SkpIgftvbGwi/HkROpCSMEnOs+mWtEloLqT4IC2sRZUKw/tNxYwp
         nXhKN/im+c/pASctPxUa5NuCMUeV7yiEGpehLQSECGM9K5H2fpZZqpyqVgdMBWMaqg52
         gcRqgmA3p8PSjU86ppM5wjYQPVFb+rBX4Ml+WwhqiUfaCWjZfC9EHd+NtfLueUWahlKg
         DkEEkWdST/Dhy6hFe8EugUSm5/AfGz9wYf6Bj0JrmnQx0t8aB7XuDj7G8YtjRDIEhSr7
         Mv6GY5pkx3JRmw+FF+MK3ZD3gx3wwaDJ/7ZKZRnxVZ0GaTzhCldCtb44uFEsHtq8o5yo
         E6ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169500; x=1727774300;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8EoVKFjbfi+a6s+4sCHipQc1F1mmCzYoxrqTTZyTQIE=;
        b=Wp8VuNf6jRrdgaPdyh3O9RTRPJTE0K25YJ2LuzMeVMILc7wydqNla2OQvsOEjjCqQ0
         gNqntReDgbf12oVUDJkoT4ffGenWWRmzlcpsVrmwwIOYiu7E+6BIggF9ydYNCDVmJkUm
         apuaBoFOcWwpgGCx+LQXCF74uCVyT59lYBSwgx23Zp06LercUYWFdWxpyxfCGYSBxypD
         cCHWlqNcQYwL5Ry2WjAgNTYpqLqZ0KJ3KTGomMBKqSLEJevdevZaRdHBIvdwKsY8YOuj
         yChnQp5o3M42A0eJyI44fllAuUGAAvjylEayPl0PJOQnQCdvZHVIqQc1xESAQ6XBbGYv
         CQEQ==
X-Forwarded-Encrypted: i=1; AJvYcCWxbQwu/c9ML/E1S7nY15jkKWDrnu0KACRc32VmaWlG/bVRdIB3mGoptD5fXRAcX8/xzoMojpmFRzbhHEM231Vt@vger.kernel.org
X-Gm-Message-State: AOJu0YyYDJ5SezxQLCZy52hRM+omL6KnnlxD8DeQzPpcTIAhcDs4NghM
	QOpuzMininJ/UKbLgMiOWV2MFFrgEc3hmAFRIkkRODn+t9kfylPDxXbKyjke7VI=
X-Google-Smtp-Source: AGHT+IGmEcpPpfKzhmTgkyAdGE/6dGxpQCEGdVziFmMCwGgv9RsAwgt586o+b4C6nRDeFTp3Ml0psA==
X-Received: by 2002:a17:907:f706:b0:a8d:4e24:5314 with SMTP id a640c23a62f3a-a90d4ffe7dbmr1302595366b.24.1727169500413;
        Tue, 24 Sep 2024 02:18:20 -0700 (PDT)
Received: from [192.168.1.3] ([89.47.253.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93930d1126sm59929766b.114.2024.09.24.02.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 02:18:19 -0700 (PDT)
Message-ID: <fe2b22aa-ad48-4279-89c0-2d846d1d405a@linaro.org>
Date: Tue, 24 Sep 2024 10:18:18 +0100
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] 2 memory fixes and a build fix
To: Ian Rogers <irogers@google.com>
References: <20240924003720.617258-1-irogers@google.com>
Content-Language: en-US
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>,
 Kan Liang <kan.liang@linux.intel.com>, Kajol Jain <kjain@linux.ibm.com>,
 Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
 "Steinar H. Gunderson" <sesse@google.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Hemant Kumar <hemant@linux.vnet.ibm.com>, linux-perf-users@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yang Jihong <yangjihong@bytedance.com>,
 leo.yan@arm.com
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20240924003720.617258-1-irogers@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24/09/2024 1:37 am, Ian Rogers wrote:
> I was looking into some lsan regressions and a latent issue with
> libdw, creating these fixes.
> 
> A thought, we should probably simplify the libdw logic but rather than
> do it here I'll do it as a separate series on top of these. The issues
> I see are:
> 
> 1) dwfl_thread_getframes is used to test for the presence of
>     libdw-dwarf-unwind. The blame date on this function is
>     2013-05-30. As the function is 10 years old I think having libdw
>     implies having dwfl_thread_getframes and so we can just merge the
>     two pieces of logic instead of having different feature tests and
>     ifdefs.
> 
> 2) similarly, dwarf_getlocations has a blame date of 2013-08-23 so
>     let's just make libdw tests test for this and make having libdw
>     imply dwarf_getlocations support.
> 
> 3) similarly, dwarf_getcfi has a blame date of 2009-06-24 so let's
>     just make libdw tests test for this and make having libdw imply
>     dwarf_getcfi support.
> 
> 4) in Makefie.config feature-dwarf is a synonym for libdw support. I
>     think using the name libdw is more intention revealing as dwarf can
>     mean multiple things. Let's change HAVE_DWARF_SUPPORT to
>     HAVE_LIBDW_SUPPORT and all similar dwarf vs libdw names.
> 
> 5) We have "#if _ELFUTILS_PREREQ(0, 142)" testing for elfutils version
>     0.142. Elfutils 0.142 was released around 2009-06-13 (via git blame
>     on the NEWS file). Let's remove the #if and ensure elfutils feature
>     tests for at least 0.142. If someone were using an incredibly old
>     version then they'd lose some elfutils support, but given the 15
>     year old age of the library I find it unlikely anyone is doing
>     this. They can also just move to a newer version.
> 
>  From the mailing list I notice also overlap with the last patch and
> this series:
> https://lore.kernel.org/lkml/20240919013513.118527-1-yangjihong@bytedance.com/
> Simplifying the libdw support will address some of those issues too.
> 
> Ian Rogers (3):
>    perf disasm: Fix capstone memory leak
>    perf probe: Fix libdw memory leak
>    perf build: Fix !HAVE_DWARF_GETLOCATIONS_SUPPORT
> 
>   tools/perf/Makefile.config     |  6 ++++++
>   tools/perf/util/disasm.c       | 11 +++++++----
>   tools/perf/util/dwarf-aux.h    |  1 +
>   tools/perf/util/probe-finder.c |  5 +++++
>   4 files changed, 19 insertions(+), 4 deletions(-)
> 

Reviewed-by: James Clark <james.clark@linaro.org>

