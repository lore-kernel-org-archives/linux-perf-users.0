Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D966C1370
	for <linux-perf-users@vger.kernel.org>; Wed, 10 Jan 2024 01:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pzUSeQR/"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-598699c0f1eso1097762eaf.2
        for <linux-perf-users@vger.kernel.org>; Tue, 09 Jan 2024 17:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704851534; x=1705456334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M2rDeNGO7hGN9d4VC57dF5HbaLWA3+xXjkD8aMs8g34=;
        b=pzUSeQR/Q8SSpslwDO1BO1Tl53/AXQJSeCTaHMbvHNPc3AbF61Qbaf+K84diWcSW6O
         HbkdUxP21qYeqQR8JBnCX2Ay4ACAe4ALfSganzGG4mpyN7LD3ZOv2r3y1Miydlqgsoja
         2AN/Zp46OJl7AHMDiXtZKHEk8x5ZZRT0vlVe1gHoPGlPTZxTck9dgdNTzM9Ft6DqW7A9
         +Z8hFCH3RQ3Vzhra29wcdKEDyrJLXJgAVoIkP0qQdrUz9b37INms+JIp5rISlBqcrKBw
         XlEUvP3++KvqZ1hka0gA/4zm0HTOsVhhIQK+FTYLcth4jPYb3THqvKG6mHEtX9h5KGmu
         5r9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704851534; x=1705456334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2rDeNGO7hGN9d4VC57dF5HbaLWA3+xXjkD8aMs8g34=;
        b=qkIgZcvsnmET2ByVuTjBi8NU5aOOtO6kJ0yxPha850CK4KJvPFwwXzhiN5V+P5UtE6
         tJBzyf+bZhBHg3wG01pQRSboJ5TOIlq5Z/qlPYtLfbjnahQgvYLbdJkrpjnpGlNmt3oJ
         xxbo7NzNGedV2JFM2HZ6+cLEkiYgiKntOrqI2IFDztfsCf5LTgA1sS/uv7c8tduPF9VC
         NkG9TIMjPGNx+oQtP/rfm3Nr0LXJk+ND8EwNwzxxDJQ6jaFdIW1PVa5daBo6DMl+L5y1
         mo25aWLoz4i5EkTm2Iq5b91xttf+8g8QqoS+U6gaBSVK3QCQIoVGsTUmZbxZ/XfikkZW
         2w3w==
X-Gm-Message-State: AOJu0YyxfkiQx1n4VGOgWE4OQFkEWc/Iokak5gO0i+kFc9smJ3PJpMUs
	Q/+o/awGg8ns3Hyh5GEXU8uYCl1lkXzLypy28MFDfU9oQFGE1w==
X-Google-Smtp-Source: AGHT+IE+iYNuWl8vePhU9BeewIJiQ17lbNLsUNnULsrNB0RvuDFWIW5FZulLdal4jfd9tcXlPBcNdQ==
X-Received: by 2002:a05:6358:8826:b0:175:89b8:b5ad with SMTP id hv38-20020a056358882600b0017589b8b5admr302752rwb.15.1704851533639;
        Tue, 09 Jan 2024 17:52:13 -0800 (PST)
Received: from debian-dev (211-75-219-200.hinet-ip.hinet.net. [211.75.219.200])
        by smtp.gmail.com with ESMTPSA id t27-20020a056a00139b00b006db18f59ac6sm517251pfg.51.2024.01.09.17.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 17:52:13 -0800 (PST)
Date: Wed, 10 Jan 2024 09:52:09 +0800
From: Leo Yan <leo.yan@linaro.org>
To: Kees Cook <kees@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, linux-perf-users@vger.kernel.org
Subject: Re: Getting PMU stats on specific syscalls
Message-ID: <20240110015209.GB44@debian-dev>
References: <202401091452.B73E21B6C@keescook>
 <CAM9d7cjBTw0RDv1LKNuiHZgTivW+jjnrtmWjm9Z4ekspWtYmrw@mail.gmail.com>
 <7CD8ADB1-7BAF-4BAD-A8C5-285BC148E691@kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CD8ADB1-7BAF-4BAD-A8C5-285BC148E691@kernel.org>

On Tue, Jan 09, 2024 at 05:01:59PM -0800, Kees Cook wrote:

[...]

> >> I can't figure out how to limit collection to only time spent during the
> >> syscall I'm interested in. I tried building synthetic events, but that
> >> doesn't seem to work...
> >
> >Hmm.. ok.  it seems you want to use PMU only for a syscall.
> >I don't think perf supports that for now, but maybe it's possible
> >to attach custom BPF programs to read perf counters at syscall
> >enter and exit and to save the diff in a map.
> 
> Does BPF have access to the PMU counters? I don't know how to even approach writing that though. :P

An alternative is to use ftrace's function_graph tracer to measure a
function duration, e.g.

      # cd /sys/kernel/debug/tracing
      # echo syscall_function_name > set_graph_function
      # echo function_graph > current_tracer

      do some test

      # cat trace

I think you even can access the PMU counter for measurement duration
in user space - though you might cannot directly measure a specific
syscall, see:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/lib/perf/tests/test-evsel.c#n127

Thanks,
Leo
