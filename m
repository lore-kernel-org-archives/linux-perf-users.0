Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F3338D3F1
	for <linux-perf-users@vger.kernel.org>; Thu, 14 May 2026 17:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778779109; cv=none; b=FbtPIdsh4PvRs2ldl/hvqW9efPjHjXM/FbXNhy9jx+37nYScnXrClAX/GY6V4tOjO2ZbDHQxdDrd7vSQ7TVR5vq4OQBT5LxhkJQYISeDjvvaNIzkbTYtvUXDYowdkNKXiaAzm4iouJtqpDuhlN6xobYAHxyxhwx/Va9Va+lB6E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778779109; c=relaxed/simple;
	bh=anylpEvHj64vfIypMfanUM6jOyXdu0JVYfNf4xCZf5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f+wwome8fw3tLXatSZtxI1r2LCg8Hgr4ai1psbDzELE05QhKy0JPviNQxF19+bUfWwnXbriFSjZ918Pns2glSPuaJo+Foa3oEh+m6FwdNypiWL12gkk2ttuyxXt5UQtHtNsZ04RyMss0SPBvkiIEdDOdU8DKK+CPNuIElG9NCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mSdTWG3v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSdTWG3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2816FC2BCB3;
	Thu, 14 May 2026 17:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778779109;
	bh=anylpEvHj64vfIypMfanUM6jOyXdu0JVYfNf4xCZf5U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mSdTWG3vcqwNqtB1uCMnD4ZjM7EHPTmZtbpTW6aq3/YXGufYLixg+DXRgcytDB7PF
	 7ydpBh7I7Ll9/B9Er8gPap4LVtySfKvrwAIgohmyBNrGaOKO5kYhJhn8MjgSc1c+D3
	 16Y/gTY5O2bIDe33cCgJMTh1E3wKGCeHKw9RzNAHVUC4OBljsjWvIR/I76S4scV1SH
	 n0BBbWnX/JGuWZU4UNXWROQTKn8/tzyc3m37zLx4f7ERjZGMl9jWf+RLfvYlHu8aHi
	 M9ZJAOXyEF/OY4WLJ9QitvPo5gQYefXalAz6wiEisNHcCCAja0sZ6OfPU49inRSiol
	 lWfgyVR5WotMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/7] misc: reject duplicate names in misc_register()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jia He" <justin.he@arm.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260514050455.2954509-6-justin.he@arm.com>
References: <20260514050455.2954509-6-justin.he@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 May 2026 17:18:28 +0000
Message-Id: <20260514171829.2816FC2BCB3@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unchecked strcmp() introduces a NULL pointer dereference kernel pa=
nic if a miscdevice is registered with a NULL name.
--

commit 45aa5c1645ea4c93820557b37841fd395426656c
Author: Jia He <justin.he@arm.com>

misc: reject duplicate names in misc_register()

This commit introduces a check in misc_register() to prevent registering
duplicate miscdevice names, returning -EEXIST early. It aims to avoid
triggering a backtrace from sysfs_create_dir_ns() when a duplicate name is
encountered.

> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
[ ... ]
> +	{
> +		struct miscdevice *c;
> +
> +		list_for_each_entry(c, &misc_list, list) {
> +			if (strcmp(c->name, misc->name) =3D=3D 0) {

Could this lead to a NULL pointer dereference if a caller passes a miscdevi=
ce
with a NULL name? For instance, if a driver fails to allocate a name string
via kasprintf() and passes NULL without checking.

Before this change, the subsystem handled NULL names somewhat gracefully.
device_create_with_groups() safely formats NULL pointers as "(null)" via %s,
and misc_seq_show() explicitly protects against them when reading /proc/mis=
c.

Additionally, if a device with a NULL name is successfully registered (such=
 as
being the first device when the list is empty), would subsequent calls to
misc_register() by other drivers crash when this loop evaluates the NULL
c->name?

> +				misc_minor_free(misc->minor);
> +				if (is_dynamic)
> +					misc->minor =3D MISC_DYNAMIC_MINOR;
> +				err =3D -EEXIST;
> +				goto out;
> +			}
> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260514050455.2954=
509-1-justin.he@arm.com?part=3D5
