Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F143143E9D2
	for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033838; cv=none; b=lR2SHL132znjOOx9vSfk0iHqBR8PS2TZLpayPZ0NBmN84oJWBUsEMpTEeuk4e4B/cB8LjNoxuqFvvhCKSZxCq+y62OgOmL4TfranrqdzAGAIcWz1BKP0RoXce1dqJbMUVDqbDab8JqzZtZcTjOXyXiTj2IRQGtVUjf9Bw196lJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033838; c=relaxed/simple;
	bh=XLXlOdwR3ch6dAcJFACBtfK27//VX8wzUuxhgCX4q68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j/SG9gZMdseSDPNrn48gkHH6XVZzidN5QNpo/tVF2ZphCeb8GEzeSP95Q2LC+xyIbThHod9k4D+CHNCUqPAFoQX6ijEBiI7lsdHEtdaKTc+wiWdU/b4LzS5QWxxQO/PD/DSlQ0w2VdlBETuJXbLd4v5pZUZgsSyAkH32aPoGXy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElOm2xML; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElOm2xML"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-42fbc544b09so207845f8f.1
        for <linux-perf-users@vger.kernel.org>; Wed, 21 Jan 2026 14:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033835; x=1769638635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y63YLxAv3Ss+sJwVJMRMRgnt189YRPpVv2etPj9fWac=;
        b=ElOm2xMLwPLvaJIdXWExLVBOPLsAxgHv72X/0jPnqmUICcUYtTRAN91/eSZNy0ZYcb
         YDSOBaGRwIK+LKmpNd9eJnUExyDha8N2edk7nprmrUM1ALm5B/Op3YbF1EYGXykUxu2o
         +a2bf5HqvjXg6bopHKp1/YPif6OQ82U7v1MJzb9akf2MohKWBXEhoE8CV0VwuucV6QZ4
         VRIpZ/9eT50aiErxi6THK1gpzgxA1VX25yofSiqYuAllNwQIj3bA2F8O0sC7J39bdJSd
         OFDY1ZP9s4RQT0ITqtGBZtwj0jTRiCD9F6PmHTDlT//5kmkkwb4nQsk6Uc86pW7RAg+4
         hrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033835; x=1769638635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y63YLxAv3Ss+sJwVJMRMRgnt189YRPpVv2etPj9fWac=;
        b=VruiyCb4bruifbptugzN/g0BiIs97On2X6vZJ1vsAE6/LmRFMsr0+aZGJNUrUPTBke
         QPRmZbXPvfjxTGL+u1o5S/AgHsvzP2ed5NXvrx0F4jgNjaoQdRln2zJeg2YbY6aiakip
         LBDr15SXFrFX2AAhOLKneCSYW36SZrsvg8gXcMtzOccKLO/taO0NuqehjU8scbi0pUqu
         SR0FVuIXf3ejFiyNMiJZ8N1BVXBTPf2bGg64ZhpD8Si0mO1lwryZSnBVdETxDPDbYmds
         rMVfYvLIX6kPGGzO31GEgyFvOxJ6qN1JUgD2Izm3QHD4pD1tUHm8CMIUyHoDUyg6Bowc
         0WdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvRp0InVTtuM8fVBQvVS8PUmBL4rkqLi2gCKLnIe489cpL96VAgTdH19ZNZ7Sg5jyOsxJN4Aqsvjlb2LkIRcsX@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9BvSxKrUv+/m1h10TGLrqdpEWLLm3HW3WRk9AwbgzOd1BXOf
	+7KNOgMWofRWkxBX7rridaKGw+n6+PS2Zhke6lzBxR9bOD1XaPPt0Wkw
X-Gm-Gg: AZuq6aJ0hmstqEDVmFMFfIpg7X0ub5RFj7j5CZe6i5Mvv2IGnDJnzlUhkEFCgbtJ5tY
	tuLex/jfdUjzv47wzIBB3tUzVwVz32l0GNb6dP5/LJ4FZoWqS3RHTScR/VUpltYgqf3X575iB1h
	a9YQ1Vx5IEbT3Bq2KTQ3O6R8jSV6HMHwwIqZ1f1H6wYfqdFMr5ELMqtutDqydiUOVPMbsheKNqL
	bn8ydR2+OMrIWAfkevXBIJ8u+BxY5Eylj3kNcWUA9x9Ir3P3SZHhV+YZ3gj/r/4d6sHhMAj2AfJ
	2RTXEc0MH8rBIkZZj6y6qvplM6kyB92C8l3RZydDSKWEz47OK9LsksM9isejKdPRbTXPZptt4ct
	eb2q5rObXuZ+tLmNOIL4y7g5a+/kcuSil8pwBVFOrse4TN7Il0PyN7Z4mTwZQ23idHWRjqqx4CN
	pk4wBCoRI7KWoNGG45p2VTCQzR8IikS4lkTNAxQbRYCPrTliqTt7BU
X-Received: by 2002:a5d:5f90:0:b0:42f:bc61:d1bd with SMTP id ffacd0b85a97d-4358ff62652mr11862672f8f.45.1769033835178;
        Wed, 21 Jan 2026 14:17:15 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4358f12ee69sm16824764f8f.11.2026.01.21.14.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:17:14 -0800 (PST)
Date: Wed, 21 Jan 2026 22:17:13 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, Adrian
 Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>,
 Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo
 <acme@redhat.com>
Subject: Re: [PATCH 3/4] perf list: Don't write to const memory
Message-ID: <20260121221713.1e7e0cf9@pumpkin>
In-Reply-To: <20260120220900.366451-4-acme@kernel.org>
References: <20260120220900.366451-1-acme@kernel.org>
	<20260120220900.366451-4-acme@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 Jan 2026 19:08:59 -0300
Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> From: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> Something now detected on fedora 44, where strchr() returns const if it
> is passed a const pointer:
> 
>   util/print-events.c: In function 'print_sdt_events':
>   util/print-events.c:89:29: error: initialization discards 'const' qualifier from pointer target type [-Werror=discarded-qualifiers]
>      89 |                 char *bid = strchr(sdt_name->s, '@');
>         |                             ^~~~~~
> 
> Fix it by using strnchr() if strchr finds the separator instead of
> temporarily scrubbing it with '\0'.

I've just looked at the full function to see WTF it is doing.
You've fixed the second strchr() not the one the compiler bleated about.
Line 89 is followed by:
	if (bid)
		*bid++ = 0;
but if it is NULL there is a fair chance the code will just explode a bit later on.
I suspect it is an error if the strings aren't "name@bar"

'show_detail' seems to be set if either the previous or next entries in the
list/tree have the same "name" - which seems strange to me.

The while thing needs more work :-(

	David

> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/print-events.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/perf/util/print-events.c b/tools/perf/util/print-events.c
> index 8f3ed83853a9e468..898cf426509790cd 100644
> --- a/tools/perf/util/print-events.c
> +++ b/tools/perf/util/print-events.c
> @@ -97,14 +97,11 @@ void print_sdt_events(const struct print_callbacks *print_cb, void *print_state)
>  		} else {
>  			next_sdt_name = strlist__next(sdt_name);
>  			if (next_sdt_name) {
> -				char *bid2 = strchr(next_sdt_name->s, '@');
> -
> -				if (bid2)
> -					*bid2 = '\0';
> -				if (strcmp(sdt_name->s, next_sdt_name->s) == 0)
> -					show_detail = true;
> -				if (bid2)
> -					*bid2 = '@';
> +				const char *bid2 = strchr(next_sdt_name->s, '@');
> +
> +				show_detail = bid2 ?
> +						strncmp(sdt_name->s, next_sdt_name->s, bid2 - next_sdt_name->s) == 0 :
> +						strcmp(sdt_name->s, next_sdt_name->s) == 0;
>  			}
>  		}
>  		last_sdt_name = sdt_name->s;

