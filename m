Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80E30E84D
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 17:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855252; cv=pass; b=On3qgUaS3cboeU78s9qD6LTL0LMrAKjsl/wTnKwCxVXzmSXoxusepByL9eYTWzaO8kSdmSjoYls/84/RnSJcxSygHEsLz1NXkMVAK3XWpniJfxQKEjSLsNYnwCK2175OGE2IUght9TEUq6IM5tBXKETtnfS6Cqx6yRwydCRPxVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855252; c=relaxed/simple;
	bh=uKbOjejL7Pc3XnBmzEbYdK0K3AgYFyVKiEgLmsWh3pg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHvUvEReQ6R2Bk7rGXhCfy5LdFWmfCsZSHloW2k//evVXXhM3DSd55eYSsg9h3hSU0LpXN7fOegkvq0q1kWGtw+MrdSt0TFYBSq6vRiptB32kn0xZK+cCSMUqAeKYOTfF+5trC+ww0sh1yVbRP+GvZ0eImgI+PtGZHW/RTIE39g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CgODvRo2; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CgODvRo2"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1270fc2bdf2so877c88.0
        for <linux-perf-users@vger.kernel.org>; Wed, 18 Mar 2026 10:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773855249; cv=none;
        d=google.com; s=arc-20240605;
        b=SZplB/MKInTLLocS03E9szcYoQKVzaW5P9gTowNCtsl0a2sJ44/ZyEKBbMNV7xhNPB
         nmqCURvIIWiX9DCrMOhGGOGqBgrV0L1agNL/NSuZTZZPkw9rGvmCYkSVYj4DiJhHm17y
         fuF1NlagCzuzIHw1GDfzf0wvcrLKERyaqp/uLYtDl7/lNceZ+m9X5OgMfGPWm45ADvUs
         gam3Z6jjCwg//HADw79pZnTSfkb/Izn/VO7uLsTkyNKKh5YmludfJRykDRu1Ux/YojTz
         hl49YgaSgbo/9FCpGD3aKbxOlq2X2JN1HMztHB2OoBd661zmCcbR+7P8QQynhvATz/80
         0ryg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+KLmvV6PEmmIFOxeHBHDnIAMALQqzUvLfQbZlGF50/0=;
        fh=6RfGgyNkhwHDLTCIL2nYxDiuK222bqVPRR14r8ylxPI=;
        b=Nbjcfqo8oAvnI7NgDJ7oAaAvY/vOOYNMtMJPr8daV9OL14z6oilGCy/np55bN73Zos
         iNiWcH92/B86kdVQjs7/tveMBsAtsiifb62WgKXUaS7OubdAhGfnookigpdgDK0c5KeL
         PAg0nXAiV7NFwpW1/m3L+VL6LfGvIxM5QEjWDUlViXb76jOGsGdHShKQ1c/w18aJSLHG
         PniiXb0/PlHf5vS+70NmiUTj+LudbvOMjH9j8ify4isjyFahoI2qHY53Qg1V51b/gwhJ
         Qu9lRwrsZBe7ahT1n+1hwvp7UhRTHjrjqsuFYkv05P53NHqSHXvbIw9GJkk2sG5VgP4T
         qcBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773855249; x=1774460049; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KLmvV6PEmmIFOxeHBHDnIAMALQqzUvLfQbZlGF50/0=;
        b=CgODvRo2t+bGXn+r3I5H+/Al7Zkw+frzJ90Y+xwdAbtDnSZrKKev85l930zZ/yMVYq
         i9R8Hrd8OSiQb1oejSDc3P3XMSppsCxHDpf3SiTgnv8U1TaoIX42sXlmEGxqyW9bnBNE
         NbzsNtp4T414aHxwe7Wcuijvn7C6j0Rc+rwTS8aiVTV4ex2A8edEhabNOwfGPcDzjPcp
         AXeNiWMJQmJgZYsI/BiKlRfd1qti/umMr6geR+VhHr7lcs5B7u/kmKlNVqG7rWDWWkC3
         +xy3p7PoUpNG/ETgkjbqVmsCNvP1fExuZJC8lqsbucLgV9nAujwS7XVQAcirr4Q2bdhP
         PkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773855249; x=1774460049;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+KLmvV6PEmmIFOxeHBHDnIAMALQqzUvLfQbZlGF50/0=;
        b=apMhNASLhRJkf4Hs1I1kn+ST+zJlapLiJ9v19ZAYZioaWEb9zV4eziLwLZ28I0dH86
         fccZq9WKteZMQ3BFMpNJmtSxc+yhre+rlzNJ3SoTMA0YSumgj9Wk61vxbiTWjejMxvYO
         tHDBBq0E9PqkAC3W3EK3pHRItlOBUyoDfvvI/lvvfIJdLp6CYaM9NaTogjqj8FEYrfWr
         4pm+w2/6Gx0zCUBXa19mJ0EPF4p7pUKff1nRq5WN8Ugs63rdQR/6y0Z2MJNolTNfYJ1J
         zkbs+9L2sqGrO+9i2BjS06XtLsnY5nDMUDZJfz+WtP/NboNZv5RmZ/C5VvfJIyb6kTVJ
         A4Nw==
X-Gm-Message-State: AOJu0YzS3pwzn41MDKnzhx3oTgdUqppXIvec2uP84iSo+KjZT/TqnOpt
	FWeul3w9IP+nCi/5NA1jrC4QzgNwJvzJnar6jWB/JjbSk4FwurAcMX5/i25Zljh5H0US/7cAYZz
	EBrvSoAtqe9uPI3UN1VJpElGsMUlqnLFO0QiC/32x
X-Gm-Gg: ATEYQzwfRWHLzN3Hq6oSAxdYdvLubDwRq99BtcUytWvsylFU1bbDKHf4ZxI7VJ6QRRn
	XXGfbWeKtCNVsLJpgEngyoKVF3RXKjSsNqjGD8cxqHUzgGmPUl9MOI2m7Np9mrBwYknvQUko7a8
	tiTAiOo247qdQPeCIFXoHVZE5gN58U50UTmg4p8LLZBipboIKIh4xrzaTw1ZzLz6+Jj6KnZZMw7
	boFV008Xi0TcbsCp/SH6/4mRD/57VuPhNJe0dQj/iURPRSTF0i6aIxoVRt91McEb9PQhphsnfFx
	Pf8p8hxg
X-Received: by 2002:a05:7022:3a8c:b0:123:3640:33e4 with SMTP id
 a92af1059eb24-12a68d2a85bmr9339c88.18.1773855248420; Wed, 18 Mar 2026
 10:34:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318034932.398913-1-nichen@iscas.ac.cn>
In-Reply-To: <20260318034932.398913-1-nichen@iscas.ac.cn>
From: Ian Rogers <irogers@google.com>
Date: Wed, 18 Mar 2026 10:33:54 -0700
X-Gm-Features: AaiRm50js0q-4f6LL7cAwnxHUZ3n7Ch3TtdS_V-vSKqvWAk-yVf7jRLfERA2SNE
Message-ID: <CAP-5=fUitzKwJONTngiW17XkS7kVr2cDS4cDL_HccJKcnR2EgQ@mail.gmail.com>
Subject: Re: [PATCH] perf intel-tpebs: Remove duplicate include of stat.h
To: Chen Ni <nichen@iscas.ac.cn>
Cc: linux-perf-users@vger.kernel.org, peterz@infradead.org, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	james.clark@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 8:54=E2=80=AFPM Chen Ni <nichen@iscas.ac.cn> wrote:
>
> Remove duplicate inclusion of stat.h in intel-tpebs.c to clean up
> redundant code.
>
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>

Reviewed-by: Ian Rogers <irogers@google.com>

We should really have a style for #includes and try to get it into the
kernel coding style. It doesn't matter so much in the kernel but
inconsistencies abound in tools, and the lack of alphabetical sorting
allows duplicates to occur. Here is a proposal that makes sense:

For any given C source file (e.g., server.c), group your #include
directives into distinct blocks separated by a blank line, ordered as
follows:
 * The Corresponding Header ("server.h")
 * C Standard Library Headers (<stdio.h>, <stdlib.h>)
 * OS/System-Specific Headers (<unistd.h>, <pthread.h>)
 * Third-Party Library Headers (<sqlite3.h>, <jansson.h>)
 * Your Project's Other Headers ("utils/logger.h", "database.h")
Within each block, alphabetize the headers.

Thanks,
Ian

> ---
>  tools/perf/util/intel-tpebs.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/tools/perf/util/intel-tpebs.c b/tools/perf/util/intel-tpebs.=
c
> index 3c958d738ca6..2af5455488b2 100644
> --- a/tools/perf/util/intel-tpebs.c
> +++ b/tools/perf/util/intel-tpebs.c
> @@ -22,7 +22,6 @@
>  #include "tool.h"
>  #include "cpumap.h"
>  #include "metricgroup.h"
> -#include "stat.h"
>  #include <sys/stat.h>
>  #include <sys/file.h>
>  #include <errno.h>
> --
> 2.25.1
>
