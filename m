Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA1E47012F
	for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786576387; cv=pass; b=XHeWD9QWRXEJHdIiSQWxgDsfpRrcv9I6vpkQabjyEKYJdBs8mL4pU/UYgQh2MrYvAa9QFAOwVTlrzjqmTGBljLnseOIRl1TM+M8VFdO+w0j9tZDpm8aIL9pyuGrkPyIjp9MmMhi3XCJRPeY0evfcP75hEWyB92w8t92ee3soJGE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786576387; c=relaxed/simple;
	bh=o7slRniLKEyAO8yGpAKSkO0PrB/ngEwhVavcAmaRvms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bNWosleSaLNg5od3A3iHAT8NAVQd5uMOxG3pox0+6j1XviR+sAR8pYUxdvOWDbW5IWnCAUgV4Px82/NUadO2T6fsuxrt9VJZc12/0hk5uFywhpNukomkVwZnQXwWiA4RB+8z1WKW9Xz3H/vp6o87t8B5S1hvqTK+5HZnGiR/K5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEgnl0L7; arc=pass smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEgnl0L7"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01c79467so51211cf.0
        for <linux-perf-users@vger.kernel.org>; Wed, 12 Aug 2026 16:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786576384; cv=none;
        d=google.com; s=arc-20260327;
        b=QEDAiOgC66w8alILn97IB8ZujcFscAjKoV4j81drglnVxYA2ayZAo+1/tYzHGHXd0A
         UD9WketYftQrFYq6gc3PrXjbWn/82vsWipL4SFEc2U1gqWPcj/GXB85N4qG+5DZKThQ0
         EShlQI8KNAH7BLyX5qjtnBU9EYUnfR7pxBiScpkqjQdtxUYOrGHT2CavndOkk3lvAdk2
         u+1deJ1j06SD59CpFT0y8Tk5Bd3VMVPV7CBTascSLhiF/IOc3jk/h3Pa8gyWMnTO1Wwm
         WIPDMgoJB/B8F6aLif4n0VUE5EWfdmf7JTf7Ua6Lt3lpJ0VM0ivS2R6KuMZERB4PWEGC
         zFOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pD7t0ccRRKNEw04l51/UHY2puNvOgxNTJRwXDkqoThA=;
        fh=Vs8XN3BMO5qrzU/CtaFLMYp4QDuZ5GMXgsfVxQ4+r9A=;
        b=aMphRETxeW/dEsSaa/KBbBo+/ekkwFQZ9zkOX41xcY6vAzZfzpQB+9EJR6kZHT/5dT
         lvSpgqcOQSbLD60JyqUuMZVsGPaH7xdN51vbm9dmVUIuFMiZd5cXUOEz1aO6it/ouNC8
         K8qeDa5qQ5jvOaeVpnyZ8+qWuGPkg6GG29+tP+mWjimQuEopp1upTfCQvyFRb0eL45TZ
         dQsdpa/AbN27uOoOEG9lARSwQemWZZoK30yRSd56dgYIH38mWAZY6wJBlqJ80wOg7LV+
         lqSuMcKck6u80cu9Jr2bSHJqXSgd7CD3LQfDOnbPKDZb5Fguo9kuJd5+l7iadIeTR5MX
         JzIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786576384; x=1787181184; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pD7t0ccRRKNEw04l51/UHY2puNvOgxNTJRwXDkqoThA=;
        b=BEgnl0L7fj1i9IHKnFJ5eUb20LkhAB7MXGyfMRoGYCJC/I43GM2g/mJfcbTo9W18Kz
         Y8Q+UdpoyHBJxVzs9Ve+D/1r+RJHB1J3XgubW6BsTY3i62Cd/8mAsfX7kehmFhVzdJBm
         o6gQu5jNjf+dajodwixNrfOKS44ilxo7IXg9MXJ9gRjVRNInGoVSFn8nCKrznkNVaE8O
         veLEgQYam8MF50HECYn++jgO9EuwCVanZU+r/iquTSXaEaIywSC4h27qwAMMQBR2VO5t
         LwHrX7jlX4PxUYWzTO/knS/WYWtWRirPdBfWo21HyxMUkA4m3CAekNUhROYCWsekfZ/2
         7bgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786576384; x=1787181184;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pD7t0ccRRKNEw04l51/UHY2puNvOgxNTJRwXDkqoThA=;
        b=KuFYfIC2G6/6qa/MUfSFZEkkFNTaUaR1xQaoRTSAFrIEjcoVVD3fwSFyjKxroJ/t3V
         AnQR/RN2lnnediPfVJFBG+4RtY5H8Umfj2WHf8JchpYSiPfC854GYY9AE7+VGfY3PMfu
         dEHlRy61U2ytVd8SO2TFKnXXoV49cqW5W2qN6LkrYvhVAAnA4ogiZ9iDwFm0tLWGVto6
         Oz5h4zWtSZaIusWBYIUxs3LrL7ZEeq/WM84Qiy9fRpj8fzDgXi25Xo48paeMd6YMP3ry
         ynp8kPSUILihzLCyJ2t4+pIPaWH+G5LXg/i5qnqWSk4P/MWHpzYN8f97glMqBUp+uZSY
         Pzxw==
X-Forwarded-Encrypted: i=1; AHgh+RonK7smQJHFslaOXwnksyUkBm6Uv6rqLmibZ4JScxBmqwM1kBtQGpVP0fbbBT1R1vkP/v1sFV4QkiEBCL5zjTb/@vger.kernel.org
X-Gm-Message-State: AOJu0YzM4fn260OxBsZZtmxLnVMqtFl5sN2xD1Q8UCXmRUhfLMyxoWrx
	E6l5K/eNTmgVj7pK3qAjyh3ssYsXxYrhJKAbNrMt9hqixn26yTPkpkWfEfCY+UC/0G7no01jUxq
	Xf4tQiaMcnHuQvVO1fjD8p8QiJD3LeVJbUP/84Rb7
X-Gm-Gg: AR+sD12U9wGvc+AlPO8fgYXe707Nb4kJM85GtE7hndG1pL/Y8gV0RYyeIHX+n5IgzIc
	srYvW44VHLDhZk/oAAIwDqmtzvUt4ccVS9Uq3BA8oSHWavXXbRDzjnzzzc/ZiGPQXHNyQjsdNgj
	mrcWlUwKNii4BWkrjfTr5e1nL4Vp9/WI4aghMNz6DNKBDoRKSkgik0XaV7/gcoyu3vzagwuzUS2
	mf1fOag1D5tV/EhEgCNSdOFF3PSPHCeQm4a2+ksG54jcj1T8EEEe0FbwXMdwPy2Sxrvk6ACjw3i
	Wus3U2dwZCghtBXdIWZMh7a/ziAK05OAjqWLpX8rQzY5nw==
X-Received: by 2002:a05:622a:1c1b:b0:51c:104c:100c with SMTP id
 d75a77b69052e-52d75b69ba7mr2829811cf.2.1786576383797; Wed, 12 Aug 2026
 16:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811175140.7235-1-acme@kernel.org> <20260811175140.7235-4-acme@kernel.org>
In-Reply-To: <20260811175140.7235-4-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Wed, 12 Aug 2026 16:12:52 -0700
X-Gm-Features: AUfX_mzrvFU0XUFGxL7fYROQBEJ8cZ2GzdriMvFLL6bCc3cA_p_haJE8fWDDgwU
Message-ID: <CAP-5=fX4AC7yPa_6xXoVmAswhUetnvth59mtPpHmX8Qp4bdf5w@mail.gmail.com>
Subject: Re: [PATCH 3/5] perf dso: Use stored fd error instead of stale errno
 in file_read() and file_size()
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, 
	Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	sashiko-bot <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 11, 2026 at 10:52=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> file_read() and file_size() use ret =3D -errno when
> dso__data(dso)->fd is negative after try_to_open_dso() fails.  By this
> point errno has been through mutex_lock(), nsinfo__mountns_enter(), and
> multiple open() attempts inside try_to_open_dso() =E2=80=94 it no longer
> reflects the actual open failure.  If errno happens to be 0, ret =3D 0
> looks like EOF rather than an error, and file_size() callers like
> dso__data_size() would then report a zero-sized file instead of
> failing.
>
> dso__data(dso)->fd is always negative on failure =E2=80=94 -errno from
> __open_dso() when no filename could be built (e.g. -EINVAL, -ENOENT),
> or -1 when do_open() itself failed =E2=80=94 and never 0, so use it direc=
tly
> instead of reading the stale global errno.
>
> Fixes: 33bdedcea2d7 ("perf tools: Protect dso cache fd with a mutex")
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---
>  tools/perf/util/dso.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/dso.c b/tools/perf/util/dso.c
> index 124193453675ca18..32ae5c78cdb906e6 100644
> --- a/tools/perf/util/dso.c
> +++ b/tools/perf/util/dso.c
> @@ -1029,7 +1029,8 @@ static ssize_t file_read(struct dso *dso, struct ma=
chine *machine,
>
>         if (dso__data(dso)->fd < 0) {
>                 dso__data(dso)->status =3D DSO_DATA_STATUS_ERROR;
> -               ret =3D -errno;
> +               /* fd is always negative here: -errno or -1, never 0 */
> +               ret =3D dso__data(dso)->fd;

nit: we can "assert(ret < 0);" to verify the comment.

>                 goto out;
>         }
>
> @@ -1151,8 +1152,9 @@ static int file_size(struct dso *dso, struct machin=
e *machine)
>         try_to_open_dso(dso, machine);
>
>         if (dso__data(dso)->fd < 0) {
> -               ret =3D -errno;
>                 dso__data(dso)->status =3D DSO_DATA_STATUS_ERROR;
> +               /* fd is always negative here: -errno or -1, never 0 */
> +               ret =3D dso__data(dso)->fd;

nit: we can "assert(ret < 0);" to verify the comment.

Thanks,
Ian

>                 goto out;
>         }
>
> --
> 2.55.0
>
