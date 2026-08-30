Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CD728B4FA
	for <linux-perf-users@vger.kernel.org>; Sun, 30 Aug 2026 06:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788071099; cv=pass; b=jZfXkHo2yN29n6isuomez7Er0fhHC73dGniVP/qV0c191ehB83KRs+x9qWAAl859LcIyOP3y8JpBhLOo31MK8/d5akPYXmcsv+HWT1w8uG//hAHlu6MZad/2K9vle9o/OdYxdTILcf8AhxsAIRd8+dQ0tv22ObzF3OmXSbjZyGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788071099; c=relaxed/simple;
	bh=mwbnbaMlp8Ae2B8ikyuYp+/a1SwbvdOTBH/giZFf1pY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=juouzYMmYcqbZ6+ZZngAmEu6+MYslt2/dVWYPGWFtHsE6j8tugds/bSPzMvL64lbrxHLWn7PO07olWz6q2IuLJvY4rATmQTezd05WRD6OOHHb6pQfsx7I7Ixk7k9RQbKMi1NCAn67cSCAGBm0fMNSNW9efd8M5hVGrJDYQ/MIis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aB9nAcNX; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aB9nAcNX"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-81ecf499af9so27538367b3.1
        for <linux-perf-users@vger.kernel.org>; Sat, 29 Aug 2026 23:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788071097; cv=none;
        d=google.com; s=arc-20260327;
        b=l/f1q6eNhWYGwUGMV+G0cEqdKO3LGJMWyhjTIdZP8TjZkATcplIvxQxKAggbqddKDr
         HoSoHtoqgwGTNSTES3GxtQv3SRTIp1UoRu9jnqeT4bkMFIL40OTv28QZHVdJNkRwzmy7
         ONuQeijp60o2xlAJ9OL0Tx1/NkQqjQ3VSvXhNAnTrn8+xDu3uEqvvTQAwW8eMRKaVTQZ
         O1eN5MVWmh7CUupjc9Vzgi6Kj2ZuxNPVUd/tFn6n3mZkKYZW0gKXGYEL3xBzWz4A2Ie8
         /SjQkxm2nqxZNgbaFC1hNoMQmZUGO7GgpAIpoasA//UVbx4ggwGs+cJw4aZqXANPJiQF
         vH3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        fh=GUBoSBA74OLtLrl4thRS+HAODC6HKDPL4cyjo/p9EpE=;
        b=MAdQtkF2lrt+aYwjKw0WyQFfDDm5rNxv8jPEiIeWGz+1a8fYKL9jR2hyzV7hD6B9Jh
         n1hnH8jFR7zPprU42+dNtWHSlH5+rTkkUue7kBgQaUigqUGqIUjoeBOnhdOZ2KXke8S2
         Avtsun4vgZfNSUEPtDvbGAcCghqnWLVffEZo0vk/ubPMIIbCRyChhDDh90cyj2vRKMt7
         fKov7cvMYoLHDNICdii5CjUxcyjgjdAqImlnx1NQfjtCFvSSe4Cebj87jqVEzJvbTt1S
         dyzc6zWZunML6RcbAF/TREYisiMDp/5X2LbwLu07YCWuazG5CVgfBXh1eKWzcapjUbIO
         LuAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788071097; x=1788675897; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        b=aB9nAcNXdlaizemZAEDW0HlxNga9CJNXMVl8w47V+7iWr8hRPcU6h6Cztrlu/SvhHS
         4SURfH99wDWltcgfyf9QkJgpGDpbu/UfM3Ivp/gXz/lxTxEf4wTn0b9wZVNLEgR4Z3kQ
         eHbj/gVgNKp5og6rPDOTXo3XYEB9a6CD7G9uyxgX1aXVlQTHexzFnSuq5oLvzELRorPs
         J11VoT6sbfw31BKvVqtSc5qmPOd9OmzxTfjr2ZEhVt2+Fuxra4/ovg+gUWeRtjTNZDO2
         hLQYetiMveRTd0vlTUsaCWUdM/N4TenodcNIprngyuV7dHYQtd+2GI0++/n84y5t8/p0
         ffIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788071097; x=1788675897;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZkOfAYL8ZF1FMqf/kMu36qJzGPBJNOCPM8hwn45vbh8=;
        b=pBLjWReTpL2Hnyelwd5TIMUDDoRbILfL5/9cWtZkyQnRyZB4/WJ88W8c7swNgF9C8i
         1+9/Uwt3+UEYvws1kyxbaAy6g5I/Ss5CJu0Y9vqiKS5VxurPnYLcCjKbOI8T7UXEtCt9
         smQQxo7vgwFI/MO/m1VyWovIvhmj/GbXXXTmh0IIJUACtMq0Wx67qSf9vQplTVBAapkZ
         IBiK/V8SSf9vlsKZaf6aaAFlEefIWry6RH2gm/pvXl/oxiMHQcGgI34sBUaKNu7DZEM2
         O3/5sb5ZfYq27tskC/gbV8tXJFsf/eT1bNdAj34z46FpvrMWBqaq5q/18+zF0i5KJU6M
         F/Qw==
X-Gm-Message-State: AFuF++lXKDIyNetUMwEhpCJdX3nGR0suDxgd275zay1Gpo9RkA6jGkWH
	NPrKIBt8Eb9x6iq6hirpYuI/MbSsA1SsIauiV6GlOlHz8fcOMHm08AeBmgCblCdlnvXRGTMjIWa
	xbzr5OTF6BQnHVYwWKE+X8V4YKU03E7k=
X-Gm-Gg: AYBFou2alLf5ona9y/+iJ4eljU7ln4iQbqvzXehyeDYB85vlQORRHqZbiwe4UZTUYgm
	Cz07i7Ab48fok7vYp6uuTbXQVTPTWhkFAQEYnFxHS5GUUt34p4S6v6RmNMITd9zA9NIPRDUTcBj
	1iQh7BSf/8Mzg0HnYO99CWbOnrdrIGSaxUgVAJAagdeA7xmUWtHVOM5csGIjo+sP813J5ucgRqW
	PQwvEtFycdn6s5wayuaCJTsf3SAi4MUnbMeRbH6CAqUn9Ap9lItQHS9w+mWSpAafMP4e8TsoPxk
	vPaNJU1WtwNgFhGV3CSjVD8f+/7ntljg0Y1c58Pagjf9r+rFQq78tsDTD70vHyN8WNGMK05cooj
	FloioP6tQ9fkaMq4pkjDWCZcDITTUK9V9sQ==
X-Received: by 2002:a05:690e:118a:b0:66e:5085:f264 with SMTP id
 956f58d0204a3-66e55740fc0mr3654481d50.49.1788071097333; Sat, 29 Aug 2026
 23:24:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260825044507.15217-1-kartikey406@gmail.com>
In-Reply-To: <20260825044507.15217-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 30 Aug 2026 11:54:45 +0530
X-Gm-Features: AcwNN1UJXiPxeecGwMmPThQayYhPtdBKrxtA98QGwRhlFNCPnG14xtruFeO76pg
Message-ID: <CADhLXY6D-+FC24c8-UWf8xW+5tVGM=J-qhViKxRWCfPDyvQ9Lw@mail.gmail.com>
Subject: Re: [PATCH v2] perf/bpf: Fix lockless access to parent_event->prog in perf_event_alloc()
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, daniel@iogearbox.net, andriin@fb.com
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 10:15=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> During fork(), perf_event_alloc() reads parent_event->prog locklessly
> which can race with concurrent detach clearing and freeing the prog via
> perf_event_free_bpf_handler() or perf_event_detach_bpf_prog(). This
> can result in a NULL pointer dereference or use-after-free in
> bpf_prog_inc().
>
> Fix by using READ_ONCE() to atomically read parent_event->prog into a
> local variable and bpf_prog_inc_not_zero() to safely increment the
> reference count only if the program is still alive. This handles both
> tracing and non-tracing event types without requiring any additional
> locking.
>
> Fixes: 85192dbf4de0 ("bpf: Convert bpf_prog refcnt to atomic64_t")
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
> v2:
> - Drop bpf_event_mutex approach which was wrong for non-tracing events
>   as perf_event_free_bpf_handler() operates locklessly
> - Use READ_ONCE() + bpf_prog_inc_not_zero() instead which handles both
>   tracing and non-tracing event types safely without any lock
> - Remove extern bpf_event_mutex from perf_event.h (no longer needed)
> - Remove static removal from bpf_trace.c (no longer needed)
> ---
>  kernel/events/core.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index ba5bd6a78fe7..39755bfacc55 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -13433,11 +13433,13 @@ perf_event_alloc(struct perf_event_attr *attr, =
int cpu,
>                 overflow_handler =3D parent_event->overflow_handler;
>                 context =3D parent_event->overflow_handler_context;
>  #if defined(CONFIG_BPF_SYSCALL) && defined(CONFIG_EVENT_TRACING)
> -               if (parent_event->prog) {
> -                       struct bpf_prog *prog =3D parent_event->prog;
> -
> -                       bpf_prog_inc(prog);
> -                       event->prog =3D prog;
> +               struct bpf_prog *prog;
> +
> +               prog =3D READ_ONCE(parent_event->prog);
> +               if (prog) {
> +                       prog =3D bpf_prog_inc_not_zero(prog);
> +                       if (!IS_ERR(prog))
> +                               event->prog =3D prog;
>                 }
>  #endif
>         }
> --
> 2.43.0
>

Gentle Reminder. Please let me know the status of this patch.

Thanks

Deepanshu
