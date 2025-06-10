Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BBD2397BE
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749571098; cv=none; b=TZzxRwdn4YuMNUdCcfr3yw0baqktFOuVenEjP2nsNP7Y4Xki4BC/D/yFFpTf1ZCwJXxIeJS0i527D0nJQatKp2H6vrkXrz+O8vSeJBFnbz/tQBe4kK9xABoUUhrIHOQfuC3rxRhjJSiDfI1/of8M0d4tNfEeSW6Jjuw44JhaPWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749571098; c=relaxed/simple;
	bh=JnvDsI2V0SfYirDWe8D7vHoy0/Tmj2p6mupoH7x8L9c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S663QEC0L1Yj7v1bao28CqCd2NmMQZyC15G0/YQDtDUzXj+iIa2dXPQVyr4Y97wSmQAikMb0Mvih9yWiEJ2Hex7dFEYpjWqzRkPd/wdDAq8uwjx1cIgW0nnXR5G+dJWvFRUlLdj9SgzH+bABmvJZxqH+0EfT9HDzLOVN8S3hBOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fpzcavzY; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpzcavzY"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad56cbc7b07so825870766b.0
        for <linux-perf-users@vger.kernel.org>; Tue, 10 Jun 2025 08:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749571095; x=1750175895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/nrvEV1OyFqB896sh+D7+1KEv79egMokePh1tw2xdC8=;
        b=fpzcavzYpIFPLSAsNFuceyxcoukQwA42mDMP7WkiNYl3VbbETe0oyw2peWRl2bLMaF
         m/G+viYKo5WKUWWt21kyyNcd5BGhibYnOZCD74L4CGCZQ3mbPI8PQcZzyzLhe/xQ/74r
         nzoK7uqRek5xAubfXo/eJKFBf6U54T+zfppK8V4o27lKtNak0uW+rn+VHOLZJuuS9au7
         LiSiUvWFg9kR8zqSuEHCXcTH5oUPnTFMuUx3DNf51gQ8OJoL5L/pDAzidKBE97HYkK9V
         VEAeHIh7wG0+ZQMug+94NSLRDRK/cVr9LDcWptW35if8PFdp8AjDbcsMvopwL92YpTG8
         /Bfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749571095; x=1750175895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/nrvEV1OyFqB896sh+D7+1KEv79egMokePh1tw2xdC8=;
        b=fPoAUyBtvMPnEIC30uyZRg7IrT/5OZMCnYmQCvMZvJ9xB4lqZftznxTHEYkniKOyvE
         AeWUo9+GlCv1qyqW/SdXdqHGEYI2HzGSTlEdQGMiWJLse7UnpZB+aOzpVW2hlqeKhFS9
         zjGlw9Xchn0a4A8/04US7vevsh8sQe9jHkUJ9kZ+4sovRj+HiUfLPIzp3E4fuE51x9c8
         +0NGiiDPoF0C+5235pcVPnIy3gb0E9sAVVV2IpAtvbVHw8VaB84P73X03o49bCBXMfUF
         SR9pCYn8Xteah094hh+mOXLzs8FuFgDe7q6JHZd893UOWej8hV3+CoExyXbBEfAPdFAt
         6p2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUCE/nHPUtAMIqZbqPVxcrdvaw0NDv2y/51V9pekLk7XT1F+ZEExKmhaAcvAnBUwHiGxylvRyLpUoRai314phXx@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3xlG6l05pkLMCAvnKzdL36a2wPe+Vdp9k2yuX+KS0mF2ZSKTZ
	QUhDaX77ghRvWW7pI+RDqYHAf8zTMo0XscClkTGTM+cQAG2vY9m54mn9Lpy+o5lEmENcCEzjhkg
	lp+zUbqNlRw1tgi+rpB4gTNLTXM34v9dtjQRzghmd
X-Gm-Gg: ASbGncucTCA0ydQ3WIhmG+lcsc0yv6NTLqp6TePBRtEmQEu2hLGDPRXuaNJVE8DAaMX
	yi1wU4QPtEDB7d1LhGQ3gCSM2HKdrIjZogl0oqyFu70hcYFTTfwvYDbvZTac3sseGLzJi8JgfsN
	oY0yoLvim/tDY8W5vSpyPrnOGTcFrGDSOqFlsgt9Y/pnIsKpU9a4uNI5kMaaL4eNNYExnR3Do=
X-Google-Smtp-Source: AGHT+IGnT2C8qqzfjiqBjWATFVDFEKGYo5bsTw0MRS4kvRY+vyWG7uSjPLyA0jhrMN5sAXMyjjxyLuUOF8Q/Cd3r9Hw=
X-Received: by 2002:a17:907:1c8e:b0:ad8:9466:3354 with SMTP id
 a640c23a62f3a-ade1a9e9335mr1661481266b.54.1749571094854; Tue, 10 Jun 2025
 08:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250610144507.2839326-1-tmricht@linux.ibm.com>
In-Reply-To: <20250610144507.2839326-1-tmricht@linux.ibm.com>
From: Chun-Tse Shao <ctshao@google.com>
Date: Tue, 10 Jun 2025 08:58:02 -0700
X-Gm-Features: AX0GCFvf4WqpGFzStiZrH2ln41VV3jtPIe_kDsffbZb2HUEZr5ZRe6tnhFUMJk8
Message-ID: <CAJpZYjWpcmqZfVFkCPa7ou6C+4zK0J07Q6iGmEPN4-zS9oDsiw@mail.gmail.com>
Subject: Re: [PATCH] perf test: Skip stat uniquifying test if unavailable
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, acme@kernel.org, namhyung@kernel.org, 
	agordeev@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com, 
	hca@linux.ibm.com, japo@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Thomas,

Thanks for the fix. Arnaldo also had a fix and should fix this issue.

https://lore.kernel.org/all/aEHugAPinlWLuTAS@x1/

Thanks,
CT


On Tue, Jun 10, 2025 at 7:45=E2=80=AFAM Thomas Richter <tmricht@linux.ibm.c=
om> wrote:
>
> Commit cb422594d6206 ("perf test: Add stat uniquifying test")
> introduced a new test case which uses an event named clockticks
> which is exported as sysfs file .../uncore_imc_0/clockticks.
> This file does not exist on s390 and causes the test case to
> always fail.
>
> Check for the existence of file clockticks and skip this
> test if the event does not exist.
>
> Output before:
>  #  perf test 87
>  87: perf stat events uniquifying       : FAILED!
>  # ./perf stat -e clockticks -A
>    event syntax error: 'clockticks'
>                         \___ Bad event name
>    ...
>  #
>
> Output after:
>  #  perf test 87
>  87: perf stat events uniquifying       : Skip
>  #
>
> Fixes: cb422594d6206 ("perf test: Add stat uniquifying test")
> Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
> Acked-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
> Cc: Chun-Tse Shao <ctshao@google.com>
> ---
>  tools/perf/tests/shell/stat+event_uniquifying.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/perf/tests/shell/stat+event_uniquifying.sh b/tools/per=
f/tests/shell/stat+event_uniquifying.sh
> index 5ec35c52b7d9..485ee6e8f574 100755
> --- a/tools/perf/tests/shell/stat+event_uniquifying.sh
> +++ b/tools/perf/tests/shell/stat+event_uniquifying.sh
> @@ -49,6 +49,11 @@ test_event_uniquifying() {
>      uniquified_event_array+=3D("${uniquified_event}")
>    done < <(${perf_tool} list -v ${event} | grep "\[Kernel PMU event\]")
>
> +  if [ -z "$uniquified_event" ]
> +  then
> +    err=3D2
> +    return
> +  fi
>    perf_command=3D"${perf_tool} stat -e $event -A -o ${stat_output} -- tr=
ue"
>    $perf_command
>
> --
> 2.49.0
>
