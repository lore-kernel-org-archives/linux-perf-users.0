Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C805343CEE4
	for <linux-perf-users@vger.kernel.org>; Wed,  1 Apr 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060518; cv=pass; b=ptN0aoNm7JUxX3dJyglmvAic0zCkxJmkqu7/t/tI8h5ZdC9IdDmfMufmqSJCi1718/NzZ4qVmtCofdAeVFUoO5lD9f7DFpqEFL94U9cIORtWatdYs5gw+bh8CK8k9OktuD2+NjDutKo/Hj8eWHXKDl1mNJbInHPztC0GzIpHwrE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060518; c=relaxed/simple;
	bh=/pbAWRtjyu/gysOFIbb8hsILqLVN9QAa/FvTW3+pzRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y2XSfic0zGKMIT2xZn7S3NdiTNupg95czRMVZqUNnRi6T+SmZOjIBm9qprukDJvSxualPO/KvDDTSweI2MQG5v7hUEXkXoYVIUB5TWlCDrHZIneDuXQ4juhUu8BG25dXalnfkyYC9+9RWhh8YaO1yrYZOASJh8k8KgpMDd//KEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Z7ISDIYR; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7ISDIYR"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b0b260d309so190875ad.1
        for <linux-perf-users@vger.kernel.org>; Wed, 01 Apr 2026 09:21:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775060516; cv=none;
        d=google.com; s=arc-20240605;
        b=EXiLJQjYY5VZNwTiq4dzN2KT+4Lwk39O+HioQTmZEZLqBwM0LIvaqFxngoCKTBz4mT
         bfx9kB/KL/oVbkfhLRxPijzb6kTSghut4YLjgGr9HJTbpRC7KCVvdaxe+6VWRGOtwWSz
         6FbvBvoYAQL6VQgN0ak1AFTBkyYyI0KIToEdfhSALI4Jtyn7K15l9WaXo2E99jeJfydK
         Q5O8BVKVHZmAMOqeRujpBuGdEueMlWhmqPCuc1dulEzaMVg/NAtoDZHRj9mJ0hY11eIp
         ODaQ4juS4MhCX+WMCsyjc5xR+liaJWVlUupzaKgGmZFvXIVN3GJOcgR0EypGt3VKDwi3
         tmZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BbYdq7S6/VuZCDSSQ4IJ+YGRE6TdTe/mlo1fYzThqrI=;
        fh=7XV0TRtuhfo54nis1EPYKzU1X7FBdKL4T52cVSSrMvU=;
        b=Lwjp7E39HQyHm5glpn4T4YzM2f5fMfVNj3+O69t5FtO3o0QvWN+aLPkTdsUtLpGw89
         7yipSNKRzPKcA9IwJA5HkxDXaDtSHuPN3glB3Kt3Iz6NtTtztqymM0APwM4ylIQqLee0
         trkOdH9vbHwRkc2ppNikFac6Vj4hVqsPQLp48q1Ytc6vdbMgTm/9vn56X4/l2UpZAWIV
         r4oCh5PSEvQ6uBX/d8/DUJKiJn7Odgm/yBPvhIASl5ul3vt+zOQpypn03zhmfaR253Ae
         Xb86NSZJ7fXHmgN0M0RJ/mvv6HYRBBZ6PErZtTf4XmPy+6k9PIFFvcmuqBfjpI38aLkm
         LAWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775060516; x=1775665316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BbYdq7S6/VuZCDSSQ4IJ+YGRE6TdTe/mlo1fYzThqrI=;
        b=Z7ISDIYR6rwFSnpWImw5FaSq9qBqwzHK2HCuI9ZG49u9yC6d/YaUlJKMF2BQTU0hcN
         D9stH8lC+CRQkfxbhf9fjexDZEdksMx4AwfbS69AEXKxZY5Fsj6L9DcLYDxivF1wrp8S
         YhUQE15hd8duBN+YSZUKRHWpdvVRjwhvrULphLJe0ibzOcO3ipHe/9GI0Ro7PrqOkc2j
         huqNGiHkhSH6iInICMaQ8rr+cCKw/qF/qeGBmxehBYMkPVhPvS756KZtYdBsrvidBtF5
         h1gv6UNDi5PKUIACGQe9STq0bEko4N9tRbrao3q+DFEVBA2+YeupPbdip8r0e+kSLgz/
         qsSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060516; x=1775665316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BbYdq7S6/VuZCDSSQ4IJ+YGRE6TdTe/mlo1fYzThqrI=;
        b=aoj9dyOvqSuzRg1ssixbuPd6Yd1AAqmD5/AjcgSIKVKTmvx78n5U3CUYZ5wQEcyXim
         Jxo1Kk5IfdCDv/L5HcInAsWi/LbGG2f1KL9Hq9BKng9yWca/ec+vtr1cC3nMlcsirQPW
         e9PUOSY+GHxzYTzJhxMb4HHCIsK+Xfc3Gs+hUco/Dk+JoPefoui9noCuu8fELmQYABJI
         hxkdtzTHsTWwoX6dJL5xGzYlWGOSYDm7KfvaasuplIU4oFiZFFJPX5gjE6Zyeh0UqOjM
         4o8pHMmcyL0D1caq6sXm6sgBctoz8LWfZVZQJBxa3cMh21elpl/tbj14ko5LRldMThdZ
         S+jg==
X-Forwarded-Encrypted: i=1; AJvYcCVQ1fedtArHRgflbUmV60Cw4R1oxW//vMx8VSaaZucVb6CcRYxndXcFZi7TcV6/r4r0hkBumtZuFmI8VjI+Igzk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8zNXr0cznQGO1mU0rBZ95kAYp3soTAYXb1nhWoO9/VlcIIEyl
	5KAxRLRzmu6f9DGKHQJ2c30bg8ZqAhX41cTSwwZaQztM61nBuIitVVXOg7QA4Rr0KJDnXS8IYJk
	aLGHxmpD3cLpsgO3rr0sxy7TPf1iWpR0J8fm7ESt/EHRKdLt+Rxe+XYkh
X-Gm-Gg: ATEYQzxaL1XmTflLttqgCX+8ON3Ydy0Rvq5bI2NwcljgsOn5Rg4aSlyK5cncfBUILMt
	Ag4ewLc+2aq+WJ5ka2T6tWb8H2mNfT8O3voXsfOiKj4ehLmz4Lh82iAWgiRbVXxookh2RqSwDq1
	ztGiBzRN4h6IEacrxckGQXB1kWBs/A+x3FhmxbqnuC5N7cB4632nbMkFK5Wg7xH82PuZDqz+COQ
	IB2bUTU1tyY8awTxvSb4tvGx0xc+I6p9jLoPUYE8iIuiEa1RExqa2id/TuXFkBCZ7enXvr93PLD
	BDXLrzTqVVjBacYlJe2hkRz/MwYaUp8qzCuQ
X-Received: by 2002:a17:902:cec1:b0:271:9873:80d9 with SMTP id
 d9443c01a7336-2b274ce92b2mr267615ad.7.1775060515366; Wed, 01 Apr 2026
 09:21:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401132442.505507-2-ashelat@redhat.com>
In-Reply-To: <20260401132442.505507-2-ashelat@redhat.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 1 Apr 2026 09:21:43 -0700
X-Gm-Features: AQROBzAyllx-MNcie5lcCXb9rdSWuDQbDdIsKmO_oCEDEcuDw-9VDQJYAxwTUv8
Message-ID: <CAP-5=fXWrq=UzP01TwAWRScZSX0+ws1yMvqo9r-=QGk-3ZZ=Fw@mail.gmail.com>
Subject: Re: [PATCH] perf dso: prevent null dsos from being added
To: Anubhav Shelat <ashelat@redhat.com>
Cc: mpetlan@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	dapeng1.mi@linux.intel.com, james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 6:26=E2=80=AFAM Anubhav Shelat <ashelat@redhat.com> =
wrote:
>
> When sorting the dso array we sometimes get a crash due to null
> comparisons in comparator functions. So prevent __dsos__add from
> adding null to the dso array to avoid out-of-memory related errors.
>
> Signed-off-by: Anubhav Shelat <ashelat@redhat.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks!
Ian

> ---
>  tools/perf/util/dsos.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/util/dsos.c b/tools/perf/util/dsos.c
> index 0a7645c7fae7..5cf8c878bab2 100644
> --- a/tools/perf/util/dsos.c
> +++ b/tools/perf/util/dsos.c
> @@ -196,6 +196,9 @@ static struct dso *__dsos__find_by_longname_id(struct=
 dsos *dsos,
>
>  int __dsos__add(struct dsos *dsos, struct dso *dso)
>  {
> +       if (!dso)
> +               return -EINVAL;
> +
>         if (dsos->cnt =3D=3D dsos->allocated) {
>                 unsigned int to_allocate =3D 2;
>                 struct dso **temp;
> --
> 2.52.0
>
