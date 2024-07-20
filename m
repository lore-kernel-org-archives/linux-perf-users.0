Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8893F38B
	for <linux-perf-users@vger.kernel.org>; Sat, 20 Jul 2024 00:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721435468; cv=none; b=LL4hcasODN51Fv44mIv4Aoadp9MNxxOgOw3fQOq1O+Ie7p5/NaF3cW0WLZTpcK1y4GGqL2duHWMv//G+lwrUgUxvT/DlTTyYXlHvXcwuzZtjQgbyBpTCWvh44mKKkgvZ6f64QyinOo2BgO3KuYKZa++HmgSSGeXLNupMRhkJgOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721435468; c=relaxed/simple;
	bh=QRDZb5ikRj0UdWgYCZCzNNA/EFtRVJbdJWn12CXARU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PrtLhipguY0d3rFD2Fm7gH9ZchXxpcJRjnGDGYYxrils73uFlQM0DKVEXTA5Vna+umpL6KAPRyWNx0UaE/LJPefkwhiygVmD2igL2P+BFTcW9OLVDt5dzwUUGD42ge6cypuPw1MkC4aeFyTvNND0jy/H6fb0q0Sw/5WaE/9WVBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2cb64529a36so1343491a91.0
        for <linux-perf-users@vger.kernel.org>; Fri, 19 Jul 2024 17:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721435467; x=1722040267;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cAIHzmq3NEgiChDl7GC1hvoHM3qtCt5CRxnsglGybuw=;
        b=rYO63N1HVnHkB1U+ljxHT8aFhWeaBp9JvCAg2O9l3iq5Jvj92KtgVHyAyW/BPwJnBM
         LReB7uTqD8NOB4ILccjnTGi2fkqP563O1B9Tjd6KObbjGVyxi2F7YNNTw2w/7x4SznhC
         bgC/J0DXhUmIOjsUmyZYW6/VXt78FbN4B0MhVYpvNitop+UzG+Sdnu9HxkUi5B6y1UWT
         1leBwKpjBMhoCDbi3hR4Yvre+4qqbOcTfeRx/vukaQckhb4+QfliJ24SfJqt+3qk1+Jz
         oLi3x1Zw8t3jjaeNKprvaTPmTT77z8aUGe6TYs3IuyGyqaAy4EmHBkf1pZOhhSIcWit/
         44JA==
X-Forwarded-Encrypted: i=1; AJvYcCVfRl9yM6L5dL1SJQxxtS5CU/Gzn83PoLSS4yQxzilTJyTSdeOrsTLzZ4m5E7KZcFbdkcJ01Jd5XwcsO4931cPch1k7xJheEcfmoZQjFTo84w==
X-Gm-Message-State: AOJu0YydfNrt2RvQdp9B0myB9/4H+7znG00d556yBpzxc0EjmwqQrgiO
	FoTlAR2UvNWwtvNchN2825ncM0XN5ehPmJ8mspJzSJImSoqKeEQ04v/YPmYK5QMnJ1CnZ51Nzht
	j6uNibBJAFCLA9KYfFQ/i6x3PkN4=
X-Google-Smtp-Source: AGHT+IEVw3aV19wuuXgbGV8sx7G0AWDA89h31mpzX4adopBjqxBtopa02nQ7DvX57hoo0neKbf5zzIt6Pqb7T5GaOfM=
X-Received: by 2002:a17:90a:f195:b0:2c9:9f50:3f9d with SMTP id
 98e67ed59e1d1-2cd273f7547mr59765a91.5.1721435466629; Fri, 19 Jul 2024
 17:31:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alpine.LRH.2.20.2407191137440.11376@Diego>
In-Reply-To: <alpine.LRH.2.20.2407191137440.11376@Diego>
From: Namhyung Kim <namhyung@kernel.org>
Date: Fri, 19 Jul 2024 17:30:55 -0700
Message-ID: <CAM9d7cjxnz_MEqSN6EsfrMejhQwGro9yjHoWrnDrugnNWuGipA@mail.gmail.com>
Subject: Re: perf test fail :: "perf stat --bpf-counters --for-each-cgroup test"
To: Michael Petlan <mpetlan@redhat.com>
Cc: acme@redhat.com, vmolnaro@redhat.com, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 19, 2024 at 2:50=E2=80=AFAM Michael Petlan <mpetlan@redhat.com>=
 wrote:
>
> Hello Namhyung,
>
> we were investigating some test failures of the testcase mentioned
> in $subj. We have narrowed it down to:
>
>     # perf stat -C 0,1 --for-each-cgroup system.slice,user.slice -e cycle=
s -- taskset -c 1 perf test -w thloop
>
>     Performance counter stats for 'CPU(s) 0,1':
>          <not counted>      cycles                           system.slice
>          3,020,401,084      cycles                           user.slice
>
>          1.009787097 seconds time elapsed
>
> As seen, the system.slice is not counted properly in our case. It
> happens even without bpf-counters being involved.
>
> There were rumours that it might be caused due to too small system
> load, but it apparently happens even when the load was replaced by
> "thloop" workload from perf-test's workload library. However, even
> so, if the load was insufficient, we'd see a value =E2=80=93 0 instead of
> "not counted". The "<not counted>" result is printed if the counter
> wasn't properly enabled and running.
>
> Have you encountered this problem? What could cause it?

Sometimes, it depends on the system activity.
I assumed there would be some system operation running
on the given CPUs at any time.  If not, it can fail..

Thanks,
Namhyung
