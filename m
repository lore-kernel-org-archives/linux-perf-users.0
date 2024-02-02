Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD15A627
	for <linux-perf-users@vger.kernel.org>; Fri,  2 Feb 2024 00:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706832319; cv=none; b=nB/bncbBUq1Nj3t41gWU9gcjdIm7NdHfcXayHD2D2i7up2ZHrbFFJSKj22YRvjJ7HgfDFbgdDeZbFY4TNiBFDNKVO34k2f0Zi9igu5jgb4u0spjw5cRzjwRd6gF16PfiX8J6VpRLXuzHvTW464HlmsBYT1+0hLjfIqFy7xQ4qg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706832319; c=relaxed/simple;
	bh=3BrrCZVW2d94Y9fzqCadw5ZyIMOfFhL9Ipq5bvwml9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oa/JxBGEsJkzTjz6N/faNqbpAQZEqBdF7ZvvfxMVf/0orbEl4t834k+pVBbgTB/U9wZ4L+ksKmpK4xf90gGwTWmHnJEci+ZEBYcyvRsKxAJVSA4WDhxlvYhnRm1tPbNkJsG0r+FUt4mTEFeQOMFdjzNkDQHIFeWwPCdv8AogSBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29026523507so1222400a91.0
        for <linux-perf-users@vger.kernel.org>; Thu, 01 Feb 2024 16:05:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706832317; x=1707437117;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbnZeu93WbvGCaMfdtFmItVJfis55wvEdqJlbRyYUPM=;
        b=IV9qt4qHbsZCKBYZ5dagZMh5LKYoAOZdjAH8caWor5CId8yfu6sE9GNk+e4NRtEU3v
         t0gE80MvYSGdkkM6nxlhd/k6Qui/Nsg6y1Y6F9XmXensH/BcnV5QlRRRsiTcoZ4lkRyi
         YrtOVjun0vc+xOXIc4An45di7S5q09Zk21GrBtDOqSop7uWpYQyDlKnjUQJfp9iiBhBP
         WoWlsPHwtSV2EzT8HIoY7pUSc52ZI+/wpzaza2tb/6nkDh0r6sfYJJ1xmDZ9X2gUO0Em
         fz+WJdhjd1c6IPg5GwXXDwJfwaTkmAi/OyyNzvIETKiYaExgolgFBpfgWbWXpAIIGOO0
         J14A==
X-Gm-Message-State: AOJu0Yz6iLeATGHEACDv60QK5RE3ub+uxTXxgvmu+HbDv+xVpmpnJt4C
	phTU5H+OLDiY42mcRMHrMbdXF2PMAy4+l+MfIJ2mNQTHMJHoREzWU0xOjNre7L87ITt8JJyyInO
	mc03SsRPHteKoYZ7tqhPt0n/AYxlUOfOYUAs=
X-Google-Smtp-Source: AGHT+IGcpTtzhUEBGt+x7Voyhs0foHQsE4wPOCYc24BdE2ImPRclVJr1zl1e3DTdtQI7GlO72/wK8ae1/6gdCErZkX8=
X-Received: by 2002:a17:90a:e2d1:b0:296:19b1:3d76 with SMTP id
 fr17-20020a17090ae2d100b0029619b13d76mr3146332pjb.37.1706832316870; Thu, 01
 Feb 2024 16:05:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131113951.17077-1-mpetlan@redhat.com>
In-Reply-To: <20240131113951.17077-1-mpetlan@redhat.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 1 Feb 2024 16:05:05 -0800
Message-ID: <CAM9d7chjET+Zy7EYcRNW=9XaC+DKcqqU+EatiGJouRCjjHscKA@mail.gmail.com>
Subject: Re: [PATCH 1/7] perf testsuite: Add common regex patters
To: Michael Petlan <mpetlan@redhat.com>
Cc: linux-perf-users@vger.kernel.org, vmolnaro@redhat.com, acme@redhat.com, 
	acme@kernel.org, mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 3:42=E2=80=AFAM Michael Petlan <mpetlan@redhat.com>=
 wrote:
>
> From: Veronika Molnarova <vmolnaro@redhat.com>
>
> Unify perf regexes for checking testing output into a single file
> to reduce duplicates and prevent errors when editing.
>
> This will be used in upcomming patches in shell tests.
>
> Signed-off-by: Veronika Molnarova <vmolnaro@redhat.com>
> Signed-off-by: Michael Petlan <mpetlan@redhat.com>
> ---
>  tools/perf/tests/shell/common/patterns.sh | 256 ++++++++++++++++++++++
>  1 file changed, 256 insertions(+)
>  create mode 100644 tools/perf/tests/shell/common/patterns.sh
>
> diff --git a/tools/perf/tests/shell/common/patterns.sh b/tools/perf/tests=
/shell/common/patterns.sh
> new file mode 100644
> index 000000000000..919a07b8b454
> --- /dev/null
> +++ b/tools/perf/tests/shell/common/patterns.sh

We have tests/shell/lib directory, maybe better to put this there.
But maybe we can move it later once we apply the series.


> @@ -0,0 +1,256 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +export RE_NUMBER=3D"[0-9\.]+"
> +# Number
> +# Examples:
> +#    123.456
> +
> +
> +export RE_NUMBER_HEX=3D"[0-9A-Fa-f]+"
> +# Hexadecimal number
> +# Examples:
> +#    1234
> +#    a58d
> +#    aBcD
> +#    deadbeef
> +
> +
> +export RE_DATE_YYYYMMDD=3D"[0-9]{4}-(?:(?:01|03|05|07|08|10|12)-(?:[0-2]=
[0-9]|3[0-1])|02-[0-2][0-9]|(?:(?:04|06|09|11)-(?:[0-2][0-9]|30)))"
> +# Date in YYYY-MM-DD form
> +# Examples:
> +#    1990-02-29
> +#    0015-07-31
> +#    2456-12-31
> +#!   2012-13-01
> +#!   1963-09-31
> +
> +
> +export RE_TIME=3D"(?:[0-1][0-9]|2[0-3]):[0-5][0-9]:[0-5][0-9]"
> +# Time
> +# Examples:
> +#    15:12:27
> +#    23:59:59
> +#!   24:00:00
> +#!   11:25:60
> +#!   17:60:15
> +
> +
> +export RE_DATE_TIME=3D"\w+\s+\w+\s+$RE_NUMBER\s+$RE_TIME\s+$RE_NUMBER"
> +# Time and date
> +# Examples:
> +#    Wed Feb 12 10:46:26 2020
> +#    Mon Mar  2 13:27:06 2020
> +#!   St =C3=BAno 12 10:57:21 CET 2020
> +#!   Po =C3=BAno 14 15:17:32 2010
> +
> +
> +export RE_ADDRESS=3D"0x$RE_NUMBER_HEX"
> +# Memory address
> +# Examples:
> +#    0x123abc
> +#    0xffffffff9abe8ae8
> +#    0x0
> +
> +
> +export RE_ADDRESS_NOT_NULL=3D"0x[0-9A-Fa-f]*[1-9A-Fa-f]+[0-9A-Fa-f]*"
> +# Memory address (not NULL)
> +# Examples:
> +#    0xffffffff9abe8ae8
> +#!   0x0
> +#!   0x0000000000000000
> +
> +export RE_PROCESS_PID=3D"\w+\/\d+"

I'm afraid the process name can have spaces like
"my proc A/9876".

Thanks,
Namhyung


> +# A process with PID
> +# Example:
> +#    sleep/4102
> +
