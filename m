Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794808230;
	b=lOPhiHzMGhy3USrrXZBj3RqjQ37W4ovisv5sBp8IZKTrUoSQ3cf/MRqgq7nGr7TVaMy3
	 QTq3eSMFNgf/lLPG1Rx+MkOv1kDUQAlV9Kup/iCfxf1UPtkZtpB9oyDKE5T8z7xsGLWwS
	 pTnQu3dut8rzvPG/b74yOpPyK2k1tKobzvHMZ5hYFlFbfZl8dYI0q3AS2FrmQN0FoWO8z
	 tZdl8s0IGuHddx7kLFhFoPjr1uAirDKPP9CfUB1QA55p5KSJMmucY7XfIqQkt57l7VXOt
	 dsA+mzfn8yE2nzO23/WfMmEzDNec5iqIN9XTng6lw4sNSBPibwKDwoCM+qyWH75zqYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794808230;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tDf2+K5IPhvGs5tj0QaPgvi7cjkx17P7OFXec62ASWo=;
	b=qg719DB7Quanhsmbyis2jAuI8I076SPT1dxbtuFz5zwJZ5J2r7zP0lN0CXPb5tIVvDqZ
	 j6GxUf4DHVva7RQdQc5VdiCDJ4lYPeFKywvs8f/VHdD1+yML+mdVWih6+iV9rbCni3swc
	 oWRPwFzNCYQ1Q2LlpcA/PVXrGt+nOHLwlAkQVBK8WlmqTwpuYO8tvZPUjWZLeUQB394+f
	 MHyk4VvsLWwzi54qCddItG6nREp9MMf0yxvli2sO5N+KDo5693v/+GHYRr54w3933NPe2
	 7ZLa4IAyHiOdPXZW/GmpoofORVbpMH1lT/mhllheFMtolB/vSTM/zSLHtWT8jguQ5/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sf1Eer3X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D48606A329;
	Mon, 16 Nov 2026 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sf1Eer3X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091481F000C4;
	Mon, 16 Nov 2026 05:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794808230;
	bh=tDf2+K5IPhvGs5tj0QaPgvi7cjkx17P7OFXec62ASWo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sf1Eer3X5tfQ6j3WcTM0x0NDlsrE3ne75g1FTAoOB93QYWgMnmNnv6bdz+oiWbwvB
	 +D2Nkz4cRiz+ecj5PtgB41mpBnORsex2EQrqxM6saIKBEHMQ2trfcJCZZ+r/l3s+9v
	 RaTrZckYRKU64+gwYTuZ4ShBzZ8fO66dPtyQW34RXCUpTaG2+FELqf9yqIM+fYV9X4
	 2CT9JntUM7PhIzDQdHeYTE8qI9FND+uMoSxSKHI2pC/+M4zj9iEGTVn9YJnCPDF78J
	 Kuj3YQE7e+Dt8WqwSS+oskC/xgGJfEzSexsFSx0u1f/r/z+QM++Od9HfPiJ/XgHv0f
	 Gvp4XU+inQtSA==
Message-ID: <sashiko-outbox-216228@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v20 11/11] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179480687961.38065.3960820028039271755.stgit@devnote2>
References: <179480675130.38065.3086970856119381693.stgit@devnote2>
 <179480687961.38065.3960820028039271755.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 05:50:29 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tracing/wprobe: truncated command logged by
  wprobe_trigger_field_parse()
--

commit 2effd66bbdbad9649e094446a260cd6b20b2df1c
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger

This commit adds BTF struct offset resolution support for the target
address field in set_wprobe and clear_wprobe event triggers, along with
documentation and a selftest.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index d2b41aa69cfdf..ad9ab606d3f47 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> @@ -1230,6 +1231,223 @@ static void wprobe_trigger_free(struct event_trig=
ger_data *data)
>  	}
>  }
> =20
> +#ifdef CONFIG_PROBE_EVENTS_BTF_ARGS

[ ... ]

> +/* parse typecast: (TYPE[,ASGN])EVENT_FIELD->FIELD[.SUBFIELD...][+-OFFS]=
 and set adjust. */
> +static int wprobe_trigger_typecast_parse(char *field_str,
> +					 struct trace_event_file *file,
> +					 struct wprobe_trigger_data *wprobe_data,
> +					 const char *glob)
> +{
> +	struct btf *btf __free(btf_put) =3D NULL;
> +	char *buf __free(kfree) =3D NULL;
> +	struct ftrace_event_field *field;
> +	const struct btf_type *type;
> +	char *assign_field;
> +	char *event_field;
> +	char *type_field;
> +	char *type_name;
> +	char *offs;
> +	long val =3D 0;
> +	int base_offset =3D field_str - glob;
> +	int event_field_offset;
> +	int id, adjust;
> +
> +	buf =3D kstrdup(field_str, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;

[ ... ]

> +static int wprobe_trigger_field_parse(char *field_str, struct trace_even=
t_file *file,
> +					struct wprobe_trigger_data *wprobe_data,
> +					const char *glob)
> +{
> +	struct ftrace_event_field *field;
> +	char *offs;
> +
> +	if (field_str[0] =3D=3D '(')
> +		return wprobe_trigger_typecast_parse(field_str, file, wprobe_data, glo=
b);
> +
> +	offs =3D strpbrk(field_str, "+-");
> +	if (offs) {
> +		long val;
> +
> +		if (kstrtol(offs, 0, &val) < 0) {
> +			wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
> +			return -EINVAL;
> +		}
> +		wprobe_data->adjust =3D val;
> +		*offs =3D '\0';
> +	}
> +
> +	field =3D trace_find_event_field(file->event_call, field_str);
> +	if (!field) {
> +		wprobe_trigger_log_err(file, glob, field_str - glob, NO_EVENT_FIELD);
> +		return -ENOENT;
> +	}
> +	if (field->size !=3D sizeof(void *)) {
> +		wprobe_trigger_log_err(file, glob, field_str - glob, WPROBE_BAD_FIELD);
> +		return -ENOEXEC;
> +	}
> +	wprobe_data->offset =3D field->offset;
> +	wprobe_data->field =3D kstrdup(field_str, GFP_KERNEL);
> +	if (!wprobe_data->field)
> +		return -ENOMEM;
> +
> +	return 0;
> +}

[ ... ]

> @@ -1306,93 +1522,25 @@ static int wprobe_trigger_cmd_parse(struct event_=
command *cmd_ops,
> =20
>  	/* clear_wprobe does not need field, but can have optional field. */
>  	if (!clear) {
> -		char *offs;
> +		char *field_str =3D strsep(&param, ":");
> =20
> -		/* Find target field, which must be equivalent to "void *" */
> -		field_str =3D strsep(&param, ":");
>  		if (!field_str) {
>  			wprobe_trigger_log_err(file, glob, strlen(glob), WPROBE_NEED_FIELD);
>  			ret =3D -EINVAL;
>  			goto out_free;
>  		}
> -
> -		offs =3D strpbrk(field_str, "+-");
> -		if (offs) {
> -			long val;
> -
> -			if (kstrtol(offs, 0, &val) < 0) {
> -				wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
> -				ret =3D -EINVAL;
> -				goto out_free;
> -			}
> -			wprobe_data->adjust =3D val;
> -			*offs =3D '\0';
> -		}
> -
> -		event =3D file->event_call;
> -		field =3D trace_find_event_field(event, field_str);
> -		if (!field) {
> -			wprobe_trigger_log_err(file, glob, field_str - glob, NO_EVENT_FIELD);
> -			ret =3D -ENOENT;
> -			goto out_free;
> -		}
> -
> -		if (field->size !=3D sizeof(void *)) {
> -			wprobe_trigger_log_err(file, glob, field_str - glob, WPROBE_BAD_FIELD=
);
> -			ret =3D -ENOEXEC;
> -			goto out_free;
> -		}
> -		wprobe_data->offset =3D field->offset;
> -		wprobe_data->field =3D kstrdup(field_str, GFP_KERNEL);
> -		if (!wprobe_data->field) {
> -			ret =3D -ENOMEM;
> +		ret =3D wprobe_trigger_field_parse(field_str, file, wprobe_data, glob);
> +		if (ret < 0)
>  			goto out_free;

[Severity: Low]
Does wprobe_trigger_log_err() still print a truncated command string when
wprobe_trigger_field_parse() or wprobe_trigger_typecast_parse() fails?

wprobe_trigger_typecast_parse() duplicates field_str to avoid mutating
glob in place, but wprobe_trigger_cmd_parse() has already split event_str
and field_str out of param using strsep(&param, ":"), which overwrites the
colon after event_str inside glob with a NUL byte:

kernel/trace/trace_wprobe.c:wprobe_trigger_cmd_parse() {
    ...
	if (param_and_filter) {
		/* Recover original trigger string to show the error log correctly. */
		if (*(param_and_filter - 1) =3D=3D '\0')
			*(param_and_filter - 1) =3D ':';
    ...
	ret =3D event_trigger_separate_filter(param_and_filter, &param, &filter, t=
rue);
    ...
	event_str =3D strsep(&param, ":");
    ...
}

Because that colon at *(field_str - 1) (and any colon after field_str when
a count follows) is never restored, tracing_log_err() stops printing glob
right after event_str, while the error caret position is still calculated
relative to field_str inside glob and lands past the end of the printed
command.  In the non-typecast path of wprobe_trigger_field_parse(),
*offs =3D '\0' also truncates glob before logging NO_EVENT_FIELD or
WPROBE_BAD_FIELD.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179480675130.38065.=
3086970856119381693.stgit@devnote2?part=3D11
