Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD94C34389F
	for <linux-perf-users@vger.kernel.org>; Fri,  7 Aug 2026 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118373; cv=none; b=uxvhxm67uGflOrTcNFvd83vBSFzo/jfj86dcYe4lxpONRhOn3S4mHyQLDImQpYaNB5j9FRotTJvWltoHsgncbIHAG7i/qm9xPv8bIwTTyJewolh/8D6Ru3Km6EUnab220G40cdnpKvNnWRTChmJajFE6qxmvnM0ykJB1+qFkJTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118373; c=relaxed/simple;
	bh=LA/YCGCDZBbzu9k7ZV3Nmen3lyy+BC7mXIiMNg/BFhA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gx3+MDe0fBqjtezXkebiovb7LlOXZV8Y3COQVwuCoeEgBed5azDufzbui5HLX7G8HbgeJWyDfbWJd9kK0NP3kvCwqblqAKW3lUgCtOfxLWa3mQ1+ujplSI2uZZG5SUcnxzi6HfGYZ96yvgfd9s4A9NcJcinTXcu7uxM9wboCPkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVOdV+AX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVOdV+AX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302251F000E9;
	Fri,  7 Aug 2026 15:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118371;
	bh=g3RC+gOak7oCwBWwyTwNkKGQKEHP4Z6Ct41bh6dG3rw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OVOdV+AXBBJNNwZYLwQt5+jzvfpujvLX0M6ZrTTqE6aZbf81aedXgjQG6L5sV/jYs
	 iuv5MYyFsryd7VxsjdOkxQT5ZQCd3iRPvGGTvqZop5tmdl9LBiCtrYN3KgjG3Fc1Mn
	 L8gEVYgNAWskpVI4ixjjxsF0wZnYuCPeUNB3JeO2hP0SibcScvyXg4WMKROoSlw7qB
	 R/0aMwzfvUaDIUYsbdCSIyo6meQqI0ltqGgBOas1cK4rrtefaQSjsdobzSyR4Kd2Cu
	 UwPccdUBWLMc/zLxGrBHQ7sCjMtL0lg2TF8B163JQIOkFcd+PtJXV6AAnj6IzhlQne
	 ndYKggBG3ZwJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 11/11] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <178611692137.237811.11807565234101581407.stgit@devnote2>
References: <178611679753.237811.10190793347982785419.stgit@devnote2>
 <178611692137.237811.11807565234101581407.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:59:30 +0000
Message-Id: <20260807155931.302251F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Speculative field parsing for `clear_wprobe` commands unconditio=
nally logs spurious errors and masks genuine syntax/memory errors.

Pre-existing issues:
- [Critical] Mixing `__free` scope-based cleanup with manual async cleanup =
on the error path causes double free and lockless list corruption.
--

--- Patch [11]: [PATCH v12 11/11] tracing/wprobe: Support BTF struct offset=
 resolution in set_wprobe trigger ---
commit f9bc82719437cd2a74bad3f90ad83888d83a0ed4
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

tracing/wprobe: Support BTF struct offset resolution in set_wprobe trigger

Allow set_wprobe trigger to use BTF struct offset resolution to specify
the target address field.

Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c2.=
1785067572.git.wangjinchao600@gmail.com/

> diff --git a/kernel/trace/trace_wprobe.c b/kernel/trace/trace_wprobe.c
> index c64bbdc90a40c..565c106a93805 100644
> --- a/kernel/trace/trace_wprobe.c
> +++ b/kernel/trace/trace_wprobe.c

[ ... ]

> @@ -1013,10 +1190,9 @@ static int wprobe_trigger_cmd_parse(struct event_c=
ommand *cmd_ops,
>  	 */
>  	struct wprobe_trigger_data *wprobe_data __free(free_wprobe_trigger_data=
) =3D NULL;
>  	struct event_trigger_data *trigger_data __free(kfree) =3D NULL;

[Severity: Critical]
This is a pre-existing issue, but does using __free() here cause a double-f=
ree
on the error paths?

If event_trigger_register() fails later in wprobe_trigger_cmd_parse(), it
calls event_trigger_free(trigger_data). This queues the trigger onto the
lockless trigger_data_free_list for asynchronous freeing by a background
kthread.

However, when the error path returns without clearing trigger_data, the
compiler-inserted __free destructors execute synchronously. This immediately
frees both wprobe_data and trigger_data while they are still linked in the
kthread's cleanup list.

When the kthread eventually processes the list, could it traverse freed
memory, trigger a use-after-free, and attempt to free the objects again?

> -	char *event_str, *field_str, *count_str, *comment;
> +	char *event_str, *comment;
>  	struct trace_event_file *wprobe_file;
>  	struct trace_array *tr =3D file->tr;
> -	struct trace_event_call *event;
>  	bool remove, clear =3D false;
>  	struct trace_wprobe *tw;
>  	char *param, *filter;

[ ... ]

> @@ -1075,42 +1251,24 @@ static int wprobe_trigger_cmd_parse(struct event_=
command *cmd_ops,
> =20
>  	/* clear_wprobe does not need field. */
>  	if (!clear) {
> -		char *offs;
> +		char *field_str =3D strsep(&param, ":");
> =20
> -		/* Find target field, which must be equivarent to "void *" */
> -		field_str =3D strsep(&param, ":");
>  		if (!field_str) {
>  			wprobe_trigger_log_err(file, glob, strlen(glob), WPROBE_NEED_FIELD);
>  			return -EINVAL;
>  		}
> -
> -		offs =3D strpbrk(field_str, "+-");
> -		if (offs) {
> -			long val;
> -
> -			if (kstrtol(offs, 0, &val) < 0) {
> -				wprobe_trigger_log_err(file, glob, offs - glob, BAD_DEREF_OFFS);
> -				return -EINVAL;
> -			}
> -			wprobe_data->adjust =3D val;
> -			*offs =3D '\0';
> -		}
> -
> -		event =3D file->event_call;
> -		field =3D trace_find_event_field(event, field_str);
> -		if (!field) {
> -			wprobe_trigger_log_err(file, glob, field_str - glob, NO_EVENT_FIELD);
> -			return -ENOENT;
> -		}
> -
> -		if (field->size !=3D sizeof(void *)) {
> -			wprobe_trigger_log_err(file, glob, field_str - glob, WPROBE_BAD_FIELD=
);
> -			return -ENOEXEC;
> +		ret =3D wprobe_trigger_field_parse(field_str, file, wprobe_data, glob);
> +		if (ret < 0)
> +			return ret;
> +	} else if (param) {
> +		char *orig_param =3D param;
> +		char *field_str =3D strsep(&param, ":");
> +
> +		ret =3D wprobe_trigger_field_parse(field_str, file, wprobe_data, glob);
> +		if (ret < 0) {
> +			/* field_str was not a field, so it must be count_str */
> +			param =3D orig_param;
>  		}

[Severity: Medium]
Will this speculative field parsing unconditionally log spurious errors?

When a valid clear_wprobe command is given with a count but no field (e.g.,
clear_wprobe:watch:10), this branch speculatively attempts to parse 10 as a
field string. wprobe_trigger_field_parse() fails and unconditionally calls
wprobe_trigger_log_err(), leaving a bogus NO_EVENT_FIELD error in the trace
error_log:

kernel/trace/trace_wprobe.c:wprobe_trigger_field_parse() {
    ...
	field =3D trace_find_event_field(file->event_call, field_str);
	if (!field) {
		wprobe_trigger_log_err(file, glob, field_str - glob, NO_EVENT_FIELD);
		return -ENOENT;
	}
    ...
}

Because this code falls back to parsing the parameter as a count upon any
negative return code, the command ultimately succeeds, but the user
receives a false-positive error in the logs.

Additionally, if field parsing encounters a genuine error (like -EINVAL
from a malformed BTF offset or -ENOMEM), will it be swallowed by the fallba=
ck
and incorrectly masked?

> -		wprobe_data->offset =3D field->offset;
> -		wprobe_data->field =3D kstrdup(field_str, GFP_KERNEL);
> -		if (!wprobe_data->field)
> -			return -ENOMEM;
>  	}
> =20
>  	trigger_data =3D trigger_data_alloc(cmd_ops, cmd, param, wprobe_data);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178611679753.237811=
.10190793347982785419.stgit@devnote2?part=3D11
