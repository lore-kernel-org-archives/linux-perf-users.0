Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7AB1C6A8
	for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721681370; cv=none; b=TFHjPhDJhfWjjPK0I/WabZoLvDIcO3XBKKJ021+pqHIhphVJjlHJSf+ly09UKmgVP7LIEduDfyv3bLQ97ULIHvm9H7dPCQ2t+t/AQASx5rqTJ/IL/86/xZzOGJn8mFLxTZRnbbJfRzOdWY/EygoPQXemENAVoQ+z1Wv1CqRah0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721681370; c=relaxed/simple;
	bh=oWbinSVpvH96rA0dOFHzW9AiDM7yXEDd/ImQASJxt2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KwlDlkp/8wDgqV3dyI4llDC1tdn2p3HlNriNESgezOzmzEtvJdT2Ne3SP3yl7L1i4N9iFK/YEc8vj1zrXhUTbRLUspT91j5wSMlGqftPHr+uZc2F2IvkqB2w7o3MfRZkoRbqE8qo+JYXh0+MptYDhrpXwmAM0jUNTQvoPTINtkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lRayo9gE; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lRayo9gE"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-38b3543541dso31815ab.0
        for <linux-perf-users@vger.kernel.org>; Mon, 22 Jul 2024 13:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721681368; x=1722286168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09v1IY2nZsi5Z0EdEgLBJS4oAdkOFd/u7ggcxR6nmTY=;
        b=lRayo9gEZzOgbU3E8fU71u6eBzJJyQ2TMcDNrJ+Jvcr9kiqWX3j2pPt0LRNJRt0xaq
         E1Kwx7bsSPsbOwVze83T6lSkNLqL1ZClif+K4GJBsOl8iMifyEqA1eXM2V4U/5MDLKyA
         TutwaBe5fyrt4vjRjJCHzxofg+wuBrmnZDs+sW7IEBPM+VnBrbMZW6qJW/CpU60vSrD9
         2EGdrQ8/vxQCdE8310CkPdMKGftRDOb4l6errd/gQGPqTDW+p9p+POLXZZviYarJ78NF
         V/v60nSfVSBm70Zy1cATEUCvO2Rl8G5gaj9SlsAGjQonDU4tY0OOGboAY56NoL+manAI
         hBQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721681368; x=1722286168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09v1IY2nZsi5Z0EdEgLBJS4oAdkOFd/u7ggcxR6nmTY=;
        b=iD4p4B4rth0v0NDz9AKrfE4phDThxV3fTvMHUzRyUoVuJujP9MIpJK5Yu51wTTMLns
         rTa2QBq5u/HXpp36wjOj5shnvP6Sw6YNUVYJXNBMigqxmyXvwJJdMyPcGF4a1V1kNQ5B
         bCDw/KgpXH4tjJtodXxLYmMEQH+X5m8sx7BiuuZQU7jbzW3YlJR9Hzg8uZ0tW75vk5j7
         ynkASD0jo9bxbtM4i6taZmxe8IeFh4Z2X5is5V7u5CeRJkUXCKWI5F534kT685mnK2wa
         2j3qwK6rHRp7eahhHlxk6hPtVKjI/S/gclfRIHd4k2DBPRnoxMhoBWPW/s91JvffnGZl
         7Qjg==
X-Gm-Message-State: AOJu0Yx6ZFRr8vYvsw8J+bZ636H9n0evkCQ5CCgmJSddFt535ePTssNb
	skURKEJD6m7P/LEbno87FZ8zrRoSbLqrAxOBuyq069J/A1USak/cWwSxrdE7F8n/WUE4ROYHrHm
	TonYDGNDvafjDu5rdWDhBBqzqN9vsjJ9jFFhe1KNq/pfemrbDB/3U
X-Google-Smtp-Source: AGHT+IE9e02aqAb1xlpxAiF+a1va6IYwxHFS6lF11BEgFQwdQhYbdE3iz1E+dlw5qFVwKjsUSfjMrRPQmCL4LHCgGnM=
X-Received: by 2002:a05:6e02:170f:b0:379:2baa:4510 with SMTP id
 e9e14a558f8ab-3994217028fmr7157135ab.23.1721681368219; Mon, 22 Jul 2024
 13:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722191858.123607-1-cachen@purestorage.com>
In-Reply-To: <20240722191858.123607-1-cachen@purestorage.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 22 Jul 2024 13:49:16 -0700
Message-ID: <CAP-5=fXrPR5gq4mz8WaOkBinfR0cAutxjysaynqGj-qUSwa2oA@mail.gmail.com>
Subject: Re: [PATCHv4] perf tool: fix dereferencing NULL al->maps
To: Casey Chen <cachen@purestorage.com>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	namhyung@kernel.org, yzhong@purestorage.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 22, 2024 at 12:19=E2=80=AFPM Casey Chen <cachen@purestorage.com=
> wrote:
>
> With 0dd5041c9a0e ("perf addr_location: Add init/exit/copy functions"),
> when cpumode is 3 (macro PERF_RECORD_MISC_HYPERVISOR),
> thread__find_map() could return with al->maps being NULL.
>
> The path below could add a callchain_cursor_node with NULL ms.maps.
>
> add_callchain_ip()
>   thread__find_symbol(.., &al)
>     thread__find_map(.., &al)   // al->maps becomes NULL
>   ms.maps =3D maps__get(al.maps)
>   callchain_cursor_append(..., &ms, ...)
>     node->ms.maps =3D maps__get(ms->maps)
>
> Then the path below would dereference NULL maps and get segfault.
>
> fill_callchain_info()
>   maps__machine(node->ms.maps);
>
> Fix it by checking if maps is NULL in fill_callchain_info().

Thanks for doing this. Can:
Signed-off-by: Casey Chen <cachen@purestorage.com>

be assumed?
Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  tools/perf/util/callchain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
> index 1730b852a947..6d075648d2cc 100644
> --- a/tools/perf/util/callchain.c
> +++ b/tools/perf/util/callchain.c
> @@ -1141,7 +1141,7 @@ int hist_entry__append_callchain(struct hist_entry =
*he, struct perf_sample *samp
>  int fill_callchain_info(struct addr_location *al, struct callchain_curso=
r_node *node,
>                         bool hide_unresolved)
>  {
> -       struct machine *machine =3D maps__machine(node->ms.maps);
> +       struct machine *machine =3D node->ms.maps ? maps__machine(node->m=
s.maps) : NULL;
>
>         maps__put(al->maps);
>         al->maps =3D maps__get(node->ms.maps);
> --
> 2.45.2
>
