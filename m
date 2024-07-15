Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5617E20323
	for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 17:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721063863; cv=none; b=gAEb6AMe3R9cCnmDhESlXKeiii4v5fXBngVRgcotOjF9qT5ZHs0zYUHY3m8ewMNZQrmEqHJywWopUMW/0k21lX1zPU+sl6HqR+EPpnPakdVnTcIMV2gzoANW513EK+cUYfLP3eGq+XRdEWZP4RtBesW0Rtu6d58LdiTky6rZ07Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721063863; c=relaxed/simple;
	bh=3Xdjfs2V+VOJTStsyE/c2aZasIGokilvafa0s97/5rQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQJcG3XI2RVk3NLs5F4q72YUS3McF9cyNUzlnZ6r72Bs40rCIMmObdSdsrk7rjCS29dU6KjoWgdN4HBFsh5qKGJhJiwmOqXvZftIgW/IbHZ6xbABiwadXYClg9jdIW7rul7KCBLAdNNdDyhMLxdrfUw7AREznRBbRGjtw1EfsDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LULeNhZD; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LULeNhZD"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-447df43324fso16511cf.1
        for <linux-perf-users@vger.kernel.org>; Mon, 15 Jul 2024 10:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721063861; x=1721668661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Xdjfs2V+VOJTStsyE/c2aZasIGokilvafa0s97/5rQ=;
        b=LULeNhZDpjm70ZmbpLcvXYBPYIUGtOVVVl/sJFWaScmhJ/Lag0Std7XEYbpo2R1LwW
         j12syBqGNu0ODH6O23KUA9RjGtXNzzvUAfqyN5QkMh5gTVAD/MOodHIry6XudcxUaWR+
         V8IjklYOMQOsEIDa75xZ+mHuVyEgyAhPrjVlCv4qmmugu8vhGpW3YyVwPsqw0IT5ixSj
         Hm5tKVvEEcd0dtKCJp/sSRYuyCeGBKovsrKQOzw+4+IJL1yQ7Ey+sRGZg7yy2nHpVTQs
         Dvn53RlSZmSDl8c8HBMQRdA8k3M+UBVnOSpE8iNMRH7z4zks51wvWw1ssKmf/0/DBaIX
         yOWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721063861; x=1721668661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Xdjfs2V+VOJTStsyE/c2aZasIGokilvafa0s97/5rQ=;
        b=kj0Ln4ccz90o9FAkDhDsCBMPCj1WjFvO6nx4caWZvrCPX02IxG9FhhZa+6S6ZzM/wz
         znF6L1H2jfz4Z2PNNUD9so8nTv/8lQc4GCdUrzdjx3reebgrgSihhc3TYQkfcZBKVbjD
         j6jcmrcpcqnKZVmrztb+NvNsr3VfuywnrSjnPqMARwJnKuwWPDwrwOt5jdiXgwrbThp8
         v8oBNdMKW0rTkAneLSlpBSu7VuEORvzHFVsZSMPOBAP8fZ4F10K9ESTQ57z/PLpN+xZU
         MYXbpQQBZwH4FlJKvHrvT6e4FZzU3T7+oc+rlbt+B4kIfhaoDVnvF+EELCG7PiR6tJs5
         THVg==
X-Forwarded-Encrypted: i=1; AJvYcCWq2PcQB9X6038SyIUdZsyMkVftPW52A2Mw9a2OLa/7kto8APUMR8+F6gBoxsljtgNshNMYKENJu3VKao1C5wX2/lvZZ4hklsUltwZvhb3jcA==
X-Gm-Message-State: AOJu0Yz9CvtZA1idABrr8oB0qFbW5ZVxN/mMglvvduyKaZ/9zGa5NL+A
	99Pp5F/j8fJ6orSCgj/h7Bbt6etln281yznT7kQjQ7IjMBEPaAF9lGpeMbatNFQ7y5T6nxRZ3bk
	oNo9+Qc9azHJXm9Z8bAGN52KfybEoUEd2rear
X-Google-Smtp-Source: AGHT+IFb9zDvvS+Vrq10c6cOTFR5NGs6k7iU81Nxww3NB6dawWRh5ZhMk3ODOFenXm5ITfakyTbHjYhL+6IvKAzBBiU=
X-Received: by 2002:a05:622a:510c:b0:447:dd47:dd5e with SMTP id
 d75a77b69052e-44f5a2cce51mr5609411cf.14.1721063861071; Mon, 15 Jul 2024
 10:17:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240715143342.52236-1-leo.yan@arm.com>
In-Reply-To: <20240715143342.52236-1-leo.yan@arm.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 15 Jul 2024 10:17:29 -0700
Message-ID: <CAP-5=fVd9pO7kKvZX7PZ6sJ+GHOV7aF=Ry98a=vknimuSTp9Lg@mail.gmail.com>
Subject: Re: [PATCH v2] perf docs: Mark the Android document as obsolete
To: Leo Yan <leo.yan@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 15, 2024 at 7:34=E2=80=AFAM Leo Yan <leo.yan@arm.com> wrote:
[snip]
> +Android NDK compilation is deprecated and no longer supported.

I think this is objectively worse than just removing the file. It is
likely the perf tool can build with clang/LLVM, I do it every day, and
the special case for Android is likely more about the libc (aka
bionic) which gradually over time has been becoming more full fat -
perhaps we need to carry somethings in tools/include for missing
definitions, but we build with musl and that's a PITA in this regard,
we've also been reducing the tools/include dependencies for perf trace
beauty support. We don't use ifuncs in the perf tool (Android's
linker/loader historically hasn't supported these) and the weak symbol
games should be okay and something I aspire to make less in the perf
tool over time. As Android uses Linux then it should work and should
be supported.

Thanks,
Ian
