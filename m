Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554751B6D08;
	Sat,  8 Feb 2025 10:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739012307; cv=none; b=pDogr5xXPUvCozwD15S21BjQgpFKwSzl+BOjfP5meL3g5qk9xUiJgB8EgUzGu9iHCe47tz3R6EtLyNiM6xVG/e///adS8zw+b5+OyOuh+qV1ST8zxRw9TVl0skFGGOwMkYz8pppL8mnFyLaM+Fqhn6XFXiC+RQWnXJAIrdUzOug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739012307; c=relaxed/simple;
	bh=HC59Proqu7a5kKk3YadUGL5qeCaPIya4GivGfD9Q6n4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJstHzH/n54LdDrh95tgO1xg+I04tS8j+kgKF9WH0b2RPZLWvbJfOU2rDRFTSEwyHtFDfrEu/dPABlR5G+HMGP4fDGeH3of2PmKxilbpAcUO7K0ge+sr29Jr6IYnow/r/tAhPEU3wrVESyxOkrssCVXURLt22gc0a7+II4WUSTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XoLycnIb; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XoLycnIb"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43932b9b09aso2759565e9.3;
        Sat, 08 Feb 2025 02:58:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739012305; x=1739617105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNqqhP8d5mEOfFUjKF7km6u3cEyjj+qEkyUHE3R255o=;
        b=XoLycnIb7R1FP0gtlOpTHKvN6AUHYbOWko2bcI/bvbMTkwlqYAxz5i8mWHdgmP01W8
         bht6JQZQ50N/JxB/bsEM9ZmY6Qsty7+v9hwNuq6RCz2MpXJjaGGmqBea1kuEJk30P8a+
         +7w+jGNMpNqbvJchlRViKinHA7aGZFDDmXW1K2BjUElfRLuRSJ0zJV4Zdfk1rhxYRhMw
         60y4b7DCE6pGSq6/lZM+SLaj6ZIigHotyvrbdvT6JeVcgt1eVIJlzSAKT88T8wKEgCw1
         y27+B2hB7L6K26unUqGRSptWtlFEyxtJAzuLNA56XO8Zoy4S3DelbJ5QkNNfJ9DEXcTF
         Y7uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739012305; x=1739617105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNqqhP8d5mEOfFUjKF7km6u3cEyjj+qEkyUHE3R255o=;
        b=PlBZhP+JXfSKqegi8AXjnLMKraZgOyjmaWJm8vgHMaKXe8vRuspQFIz13Ewaw3KG+d
         d6yAL9T3tkNEj6LrDncYR9e8JwddG0J8vhWazdKYUOd2eZRo2Pk+LvHnJzf8D95fma/i
         mmOfxWQKsAlHe+6u8QCv44mt/GzlyO/jngX6COkilFElzmnwtTP3ekITNJf3Wnu++Jvw
         JVfrRyI3GYI06taymsDw0QwuVh9wXRVdxAeAXqJTswqcUn7LOJdaQ8W4xIlGC21aJhOJ
         8mwtde4NxZDQXq2Txfm1Xeo8rMXGy4w9IyG9EBN9gRkepBq1mjkdorzZ06W8PhBUAFyj
         Rx7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlxmPmC0BoNOp8jq+kTcJg4p/UNyRYMLirbkK3NfHUzM06AXFD0df9VTORBmkJ7SFtx7bfXHWJ8syboEw=@vger.kernel.org, AJvYcCXUnq846iYG46PfRfIQu08P9pRhiHDMVTSm+R9YkbRFfEWitG5HJQZzCme2oaROd2X5ERnfcDTpOez3mZadCaPRCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzH9Z/7yS/iUzPIFoJio16o/GcmM5gm68KFpTRtwM3n9c6//gPN
	8x+m9KXfUvied5uGkXO3xyQvckm2EXF3DRzGAYxt+kmyDsbvzpOC
X-Gm-Gg: ASbGncvfplcrv9DDWXIaMjhEf1U/x5pjMKx/oZZMER3I5J5mXu2w0J1cL0FRmjsg3Ga
	gZnwuwNmf56jjltOi29eEPLlfXCEv0EFdDH7y0KGszy+2h2LESzYjcaYGDOWkX9TrR2G2AxuAgj
	3+HD09I500ZX1Lbl2P0E56cDOFUT3AUAsB8+h9hzvmwW5S6LY0zEnrZMQxixNWe+SIp+jo3E5CT
	dqZoOLpdHRKNsSsrQDmGOfUFYQ35VdAybIl7FB6Q/VmkNwabx51YRDvwnimq9mcjnY841QQgWnK
	WWrQGckNVhQmltABYMtQzSHdZgefIIxppMCY9d4NmDUgnL0DI+PcBA==
X-Google-Smtp-Source: AGHT+IGI6rjXAZop36zSG90oUjlAUybcAcwzJW/10yNuGLLIJasyrmCRrjJ5ueyR9wWlflLpnHpCXQ==
X-Received: by 2002:a05:600c:1da7:b0:439:34e2:455f with SMTP id 5b1f17b1804b1-43934e24665mr7757815e9.12.1739012304348;
        Sat, 08 Feb 2025 02:58:24 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4390db11200sm116292145e9.38.2025.02.08.02.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 02:58:23 -0800 (PST)
Date: Sat, 8 Feb 2025 10:58:21 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa
 <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Kan Liang
 <kan.liang@linux.intel.com>, Sam James <sam@gentoo.org>, Jesper Juhl
 <jesperjuhl76@gmail.com>, James Clark <james.clark@linaro.org>, Zhongqiu
 Han <quic_zhonhan@quicinc.com>, Yicong Yang <yangyicong@hisilicon.com>,
 Thomas Richter <tmricht@linux.ibm.com>, Michael Petlan
 <mpetlan@redhat.com>, Veronika Molnarova <vmolnaro@redhat.com>, Anne Macedo
 <retpolanne@posteo.net>, Dominique Martinet <asmadeus@codewreck.org>,
 Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, Junhao He
 <hejunhao3@huawei.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, "Krzysztof =?UTF-8?B?xYFvcGF0b3dza2k=?="
 <krzysztof.m.lopatowski@gmail.com>
Subject: Re: [PATCH v2 0/7] Add io_dir to avoid memory overhead from opendir
Message-ID: <20250208105821.1cdb54fc@pumpkin>
In-Reply-To: <20250207232452.994822-1-irogers@google.com>
References: <20250207232452.994822-1-irogers@google.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  7 Feb 2025 15:24:41 -0800
Ian Rogers <irogers@google.com> wrote:

> glibc's opendir allocates a minimum of 32kb, when called recursively
> for a directory tree the memory consumption can add up - nearly 300kb
> during perf start-up when processing modules. Add a stack allocated
> variant of readdir sized a little more than 1kb

Does 300kB really matter?

You seem to be trading memory allocation against system calls.
My 'gut feel' is that the system call cost will dominate.
(Unless all the directories are small.)

There might, of course, be other code in glibc that is designed
to make it all slower than necessary.

	David
