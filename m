Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACADF158520
	for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504189; cv=none; b=IzuIFPYJPckfdALMuvqiRa+ppwpeUifbvlzLBEaYTOyWtqoZn5kI3UE/qgLAKZRAehwtfYxca3m+jiAw62aU2dQex8q3tUkaUS2w6HRirkTdQacaKIbkru0XXfWXcjhoTxCXfvvjtsJQ1wbn51BJZd3WMmSfkA3/OdzO3gzbDrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504189; c=relaxed/simple;
	bh=v3AVXPBqyn/VEB9q398QPkPemqU6//8ktrFh466Eb/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/3zqcpOPYZOIRUmD/nfGhquWamITfr4qt0HFooLGRDM0TTJOfk/7x1W4qZikrLw6j57Cs6MC5zKmO3VyIDee81vFEr2NxwAYH2zIQu9+w5f617hLCj40KQao7zHmgpniIXMQmZzHStgCqu1mH6CV+mbsYGcJ4FGH7277d4hWTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KzT4O4LQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KzT4O4LQ"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-221ac1f849fso169505ad.1
        for <linux-perf-users@vger.kernel.org>; Tue, 25 Feb 2025 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740504186; x=1741108986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRS7zRNsUBaTX8e7za4k3/mNtUpQo7uf5jo12sCbNZA=;
        b=KzT4O4LQEy5fJt3mL2+Ty8w968WcvvQXtIVbGdoFQzQQbOb9IrteXum7PrX0jYcp+m
         eYhmWtCqaKYwsgqY5oUCznjTIvyeCG1W1lWBaqnNTu5ZMTiHVg823tW7EtI7uPbBfZMc
         LeSz9WWOr0WvpmRVwrNsB0gg4/cJVUPokIhxt+VBX8UdzvZh+NyLQqIIDLGqAQhBeGoZ
         fGAxu/kFHGDaaH2NpcKlqpp2cIPjU4y503vbTvjSGeG+Onr/lTrlHSj8PrPpJZXtwfF7
         PPHzUZ975+xRDxZJVY6gY8Ik3VtNsx/ZP3cx46Z70X2Hgvf2OrLqV8UV1ikc/+LzpcNn
         Z8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740504186; x=1741108986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRS7zRNsUBaTX8e7za4k3/mNtUpQo7uf5jo12sCbNZA=;
        b=eRysSruXNgzc1BVLy2RAWyMCLVCd6WjCbKgxGniykbfsSplJJncUyETRzIPwgu1ygu
         lHYSY0C5snnvAg5J8PUryfDiH+3F+suGJA9pMPO2EgENILKGCsiudt4D09Rs3MyJBiWi
         HrQKyzUWY9BwQNpXcJr7CwyhwY2gaMBrmKEDCvh5iH0iNxnOzHwRu0H/kkAY1WIKMuBW
         Q51Iv8XggZIwDg5aymuXBYU/8Sjtec018M57KXN6lRNmvjWGkGZBMu+hlVGaBEw3OZfP
         K2fwj3EZHZDmwj6b44oglFWEkjv+xU57OZWidAAB4+LFuzKOfhIcunO1t2c8iZ5lMYas
         k//g==
X-Gm-Message-State: AOJu0YxxTHR35/R6URffcZUtS6sx08Y6rOB0HhC6xhi6Z65eezxEktRe
	BPYpIkCb61gnE0W6y9wkYORCaCYCZ7MYsNbwdOFbaMbUB2/U4xZGnbWUQAWprDgJHF4EDYZNVRe
	9HsQGKMWTRSfXemGxJWQPga2mMy8cVKIdmtp6
X-Gm-Gg: ASbGnctaqPz91S0B806ayD2h5byp0w1DZQPiFYcCJ7P6W+er4PK+B4S3h9vOvoJrG3o
	hxDGDSwipxLhFn9QrGxJek0DEAC+qQgSXzAGjbJqcp4ROjPuPG71s95rar4Cl+R+Z4JOmvbWElI
	3YKQxpgY+CZkCHZz56Cd725hTaDZqwpcldOqs=
X-Google-Smtp-Source: AGHT+IGC8PbZnAX1dM7vF/eknw+nIFz4/wdvAqDFmpDDAoGSei+HpX67HLH8P4ooCjMrPXiK2pEFl5M7Fgr02/I0jU0=
X-Received: by 2002:a17:902:d2cc:b0:215:9327:5aed with SMTP id
 d9443c01a7336-22307a98a40mr3749615ad.20.1740504185776; Tue, 25 Feb 2025
 09:23:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250225164639.522741-1-james.clark@linaro.org> <20250225164639.522741-4-james.clark@linaro.org>
In-Reply-To: <20250225164639.522741-4-james.clark@linaro.org>
From: Ian Rogers <irogers@google.com>
Date: Tue, 25 Feb 2025 09:22:54 -0800
X-Gm-Features: AWEUYZkkYjNpwQEAg6yCL_UkAsz9MOXgB0BQHPDdqu5Op5Bsw52KT0TKFYbCsoE
Message-ID: <CAP-5=fVEQvP7viecoGzLyUv1_Dsx6FhvmrYakWgi_TrBXPGSiw@mail.gmail.com>
Subject: Re: [PATCH 3/3] perf list: Document -v option deduplication feature
To: James Clark <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org, namhyung@kernel.org, cyy@cyyself.name, 
	Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, "Liang, Kan" <kan.liang@linux.intel.com>, 
	Yoshihiro Furudera <fj5100bi@fujitsu.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Weilin Wang <weilin.wang@intel.com>, Junhao He <hejunhao3@huawei.com>, 
	Jean-Philippe Romain <jean-philippe.romain@foss.st.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 8:47=E2=80=AFAM James Clark <james.clark@linaro.org=
> wrote:
>
> -v disables deduplication of similarly suffixed PMUs so add it to the
> help and doc strings.
>
> Signed-off-by: James Clark <james.clark@linaro.org>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian


> ---
>  tools/perf/Documentation/perf-list.txt | 2 +-
>  tools/perf/builtin-list.c              | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/Documentation/perf-list.txt b/tools/perf/Document=
ation/perf-list.txt
> index c3ffd93f94d7..8914f12d2b85 100644
> --- a/tools/perf/Documentation/perf-list.txt
> +++ b/tools/perf/Documentation/perf-list.txt
> @@ -27,7 +27,7 @@ Don't print descriptions.
>
>  -v::
>  --long-desc::
> -Print longer event descriptions.
> +Print longer event descriptions and all similar PMUs with alphanumeric s=
uffixes.
>
>  --debug::
>  Enable debugging output.
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index c19826f218a0..fed482adb039 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -527,7 +527,7 @@ int cmd_list(int argc, const char **argv)
>                 OPT_BOOLEAN('d', "desc", &default_ps.desc,
>                             "Print extra event descriptions. --no-desc to=
 not print."),
>                 OPT_BOOLEAN('v', "long-desc", &default_ps.long_desc,
> -                           "Print longer event descriptions."),
> +                           "Print longer event descriptions and all simi=
lar PMUs with alphanumeric suffixes."),
>                 OPT_BOOLEAN(0, "details", &default_ps.detailed,
>                             "Print information on the perf event names an=
d expressions used internally by events."),
>                 OPT_STRING('o', "output", &output_path, "file", "output f=
ile name"),
> --
> 2.34.1
>
