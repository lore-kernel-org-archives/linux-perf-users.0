Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF6719F113
	for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347681; cv=none; b=TNFDtrPcNvg/KCiU2wDAbKrq81Cxou0p1rRY1hI5Kc3H+k6k/vWmeHROzyq2zQw6ohFOzi1JTOg47fOEyBXg+G0Q++pld3XBAkNWN96YbpQtw4J4jX90gf6awV5S0Gy6qNOralSNypnYBobCWKObpBvsKu36ZlC/XT4BUbHK9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347681; c=relaxed/simple;
	bh=OMNp9jkX5LcJ1MhdA6nAc3FAGeaTDVrDDXq3lMyUAj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jV+AiTecI4yQB8EvcOy66uJIdSz0vgUYZKTIENFcX4UrYz+5Szm7Andmk3F22MQ2rLENdyRE9WQjt+6nNMchtipEW6Wcj8OXyuIVueE0B25L+H+DdnrOpwLL75rmJHrvVdpyJWezYPm12jWMeEcuY2IBXWf7WH6q8bvWonmeLlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Xz+Is4XS; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xz+Is4XS"
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a3b28ac9a1so1505ab.1
        for <linux-perf-users@vger.kernel.org>; Mon, 11 Nov 2024 09:54:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731347679; x=1731952479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a6ayBpaSwQCVtHI4Mx9iZamOC7hgmqt5Edk2VxrNlbY=;
        b=Xz+Is4XSqlq84NqdumhC0DyIgzRtBYBAirmWWE8hmIxKQs4NudlvTupXFqTg0j6HY0
         NGVhCG6kko+SGpqPHqC18cqrO2t8jBcfyS9/9kUbn2UHGSD0bnCmKi0Zv20PaAyXZ2cP
         Kyh5jx8vYQoQmctQgatlrZrV6ZRckALBcZvH9Xuw8C35npaZO+vf2gXxg1sgztS4QJSQ
         f+Qwyy1BugXj86ceHv6Sp8IOZBHkeUmxhhvVHkXiMDCkfXGLBUoKmrzEsr7d6qS5Nm3a
         +Wqwh9N69DY2OgW9CE0ZkbTGPNmL4umBPukwv68d+UHYfRBntVF4j2ENuitmSM1vsZY7
         CVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731347679; x=1731952479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a6ayBpaSwQCVtHI4Mx9iZamOC7hgmqt5Edk2VxrNlbY=;
        b=f9p4F8Ql04/FJ/sxKtOQYuvD13rV/PGf6PIFZyZV7/sgnIqjtDbbYIuSCnre04faii
         3f2zUk67E5ReJPPjkXpbNbkG0jshC0YM5qUsGrob+GjJ7heESkoHU01teErpDhokNDbY
         zjdwIGAegMVsBosYiPZrA1WBaH1DKuvwgqZNJlmBtkKB60BubKy5HdWX4BTbN53iawzA
         QJX5yNCHnjVZ/U6S7P8MdJ0zqj/6CE5ZcXWkFmao4Glr1Lwst5Vcs+wEFFrJo9Ll9kPk
         JM4Pq+Ild8MC9TYMG6G63fLdsTeHc9eAeOVRZ2qGJTa1xZdTaEq+Jsx7NhqmpYWRHuHe
         Tcew==
X-Forwarded-Encrypted: i=1; AJvYcCVLwEmQ3cNYQaZma+dxGXoRgIwlwvvkF25hMGPahfOkcU60hnzTcNEmvatU6Y6vcPQmdd+s3rRzikLfWpwSQ1bc@vger.kernel.org
X-Gm-Message-State: AOJu0YwCzWHjeoRqmMlasqpAmO/o4sKEQWGHVSaB9oeHRs1IQc5tA9i0
	de8dBJgPdIAp7onX+zFMYcU2J70xS9TTb9S6u/SkJeTNxD0gWiHyynpjov4+DhwRIk1QEE+FqLu
	y0/NWoA8MeCNHLz7WTEdetfZPDhD3qrLAuPKv
X-Gm-Gg: ASbGncv3l+IBKuK0u2yQmv3e2GmPH8cNe1c+QhTiDFzsFvgNBIxQf/h7zI9z+7dIjlL
	DW2VHoh8j2adI8XfeW5pkhTDpfW3di/Gq9E5USnFvJSl/zmFhU1EOu+o8gHMeXUs=
X-Google-Smtp-Source: AGHT+IHQrkyjKMcHJ6XD9V84z+MszNFs5/j186PudTdO+dhvBA87kliE5MV62rQMct02oHl4hYseq7L96w+xyn6jdfw=
X-Received: by 2002:a05:6e02:168f:b0:39d:1b64:3551 with SMTP id
 e9e14a558f8ab-3a6f95642ddmr8575615ab.19.1731347679175; Mon, 11 Nov 2024
 09:54:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241108204137.2444151-1-howardchu95@gmail.com> <20241108204137.2444151-6-howardchu95@gmail.com>
In-Reply-To: <20241108204137.2444151-6-howardchu95@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Mon, 11 Nov 2024 09:54:27 -0800
Message-ID: <CAP-5=fXDd2MUvukB6NVMN962wxjPN6_F-AxOxOUUb-uj5BVV0A@mail.gmail.com>
Subject: Re: [PATCH v7 05/10] perf record --off-cpu: Dump off-cpu samples in BPF
To: Howard Chu <howardchu95@gmail.com>
Cc: acme@kernel.org, peterz@infradead.org, namhyung@kernel.org, 
	mingo@redhat.com, mark.rutland@arm.com, james.clark@linaro.org, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 12:41=E2=80=AFPM Howard Chu <howardchu95@gmail.com> =
wrote:
>
> Collect tid, period, callchain, and cgroup id and dump them when off-cpu
> time threshold is reached.
>
> We don't collect the off-cpu time twice (the delta), it's either in
> direct samples, or accumulated samples that are dumped at the end of
> perf.data.
>
> Suggested-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Howard Chu <howardchu95@gmail.com>
> ---
>  tools/perf/util/bpf_skel/off_cpu.bpf.c | 83 ++++++++++++++++++++++++--
>  1 file changed, 78 insertions(+), 5 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/off_cpu.bpf.c b/tools/perf/util/bpf=
_skel/off_cpu.bpf.c
> index dc6acafb9353..bf652c30b1c9 100644
> --- a/tools/perf/util/bpf_skel/off_cpu.bpf.c
> +++ b/tools/perf/util/bpf_skel/off_cpu.bpf.c
> @@ -18,10 +18,18 @@
>  #define MAX_STACKS   32
>  #define MAX_ENTRIES  102400
>
> +#define MAX_CPUS  4096
> +#define MAX_OFFCPU_LEN 37
> +
> +struct stack {
> +       u64 array[MAX_STACKS];
> +};
> +
>  struct tstamp_data {
>         __u32 stack_id;
>         __u32 state;
>         __u64 timestamp;
> +       struct stack stack;
>  };
>
>  struct offcpu_key {
> @@ -39,6 +47,24 @@ struct {
>         __uint(max_entries, MAX_ENTRIES);
>  } stacks SEC(".maps");
>
> +struct offcpu_data {
> +       u64 array[MAX_OFFCPU_LEN];
> +};
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(__u32));
> +       __uint(max_entries, MAX_CPUS);
> +} offcpu_output SEC(".maps");

Does patch 4 build without this definition? (we're in patch 5 here). I
think this should be in patch 4.

> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_PERCPU_ARRAY);
> +       __uint(key_size, sizeof(__u32));
> +       __uint(value_size, sizeof(struct offcpu_data));
> +       __uint(max_entries, 1);
> +} offcpu_payload SEC(".maps");
> +
>  struct {
>         __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
>         __uint(map_flags, BPF_F_NO_PREALLOC);
> @@ -185,6 +211,39 @@ static inline int can_record(struct task_struct *t, =
int state)
>         return 1;
>  }
>
> +static inline int copy_stack(struct stack *from, struct offcpu_data *to,=
 int n)
> +{
> +       int len =3D 0;
> +
> +       for (int i =3D 0; i < MAX_STACKS && from->array[i]; ++i, ++len)
> +               to->array[n + 2 + i] =3D from->array[i];
> +
> +       return len;
> +}
> +

Dump is something of a generic name. Could you kernel-doc this
function to describe the behavior?

> +static int off_cpu_dump(void *ctx, struct offcpu_data *data, struct offc=
pu_key *key,
> +                       struct stack *stack, __u64 delta, __u64 timestamp=
)
> +{
> +       /* dump tid, period, callchain, and cgroup id */
> +       int n =3D 0, len =3D 0;
> +
> +       data->array[n++] =3D (u64)key->tgid << 32 | key->pid;
> +       data->array[n++] =3D delta;
> +
> +       /* data->array[n] is callchain->nr (updated later) */
> +       data->array[n + 1] =3D PERF_CONTEXT_USER;
> +       data->array[n + 2] =3D 0;
> +       len =3D copy_stack(stack, data, n);
> +
> +       /* update length of callchain */
> +       data->array[n] =3D len + 1;
> +       n +=3D len + 2;
> +
> +       data->array[n++] =3D key->cgroup_id;
> +
> +       return bpf_perf_event_output(ctx, &offcpu_output, BPF_F_CURRENT_C=
PU, data, n * sizeof(u64));
> +}
> +
>  static int off_cpu_stat(u64 *ctx, struct task_struct *prev,
>                         struct task_struct *next, int state)
>  {
> @@ -209,6 +268,12 @@ static int off_cpu_stat(u64 *ctx, struct task_struct=
 *prev,
>         pelem->state =3D state;
>         pelem->stack_id =3D stack_id;
>
> +       /*
> +        * If stacks are successfully collected by bpf_get_stackid(), col=
lect them once more
> +        * in task_storage for direct off-cpu sample dumping
> +        */
> +       if (stack_id > 0 && bpf_get_stack(ctx, &pelem->stack, MAX_STACKS =
* sizeof(u64), BPF_F_USER_STACK)) {
> +       }

Why the empty if?

> +
>  next:
>         pelem =3D bpf_task_storage_get(&tstamp, next, NULL, 0);
>
> @@ -223,11 +288,19 @@ static int off_cpu_stat(u64 *ctx, struct task_struc=
t *prev,
>                 __u64 delta =3D ts - pelem->timestamp;
>                 __u64 *total;
>
> -               total =3D bpf_map_lookup_elem(&off_cpu, &key);
> -               if (total)
> -                       *total +=3D delta;
> -               else
> -                       bpf_map_update_elem(&off_cpu, &key, &delta, BPF_A=
NY);
> +               if (delta >=3D offcpu_thresh) {
> +                       int zero =3D 0;
> +                       struct offcpu_data *data =3D bpf_map_lookup_elem(=
&offcpu_payload, &zero);
> +
> +                       if (data)
> +                               off_cpu_dump(ctx, data, &key, &pelem->sta=
ck, delta, pelem->timestamp);
> +               } else {
> +                       total =3D bpf_map_lookup_elem(&off_cpu, &key);
> +                       if (total)
> +                               *total +=3D delta;
> +                       else
> +                               bpf_map_update_elem(&off_cpu, &key, &delt=
a, BPF_ANY);
> +               }

Looks good! :-)

Thanks,
Ian

>
>                 /* prevent to reuse the timestamp later */
>                 pelem->timestamp =3D 0;
> --
> 2.43.0
>
