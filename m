Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D1396577
	for <linux-perf-users@vger.kernel.org>; Wed,  8 Apr 2026 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635692; cv=none; b=fMFsUAZqhkGuSrM9Ex9wtCp0FYxS0XbCj90bht90+1N+Mgj18tEDoXvUqEH4zkJVvbatyIQjL4D4d4sZaRNU8g8hRQTnuZ69WUNtuXBz5Tmbe82Sga58uNwTDVRlhT334pysDlRNNdlXMq8/xYMVIYwh8tl5CQ/kcLE2t3h1Grs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635692; c=relaxed/simple;
	bh=fhX++rvzqd4J9wJ/7i4nHR/JYmKqpO83zomoZBI0+4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mjEpPVgenMFZMnQXbwv/6U5G/e66d8mS6xjSy7eN5uCReblMQCEwu6Zklu+3Rw6XrnRkdRMlGgHRHUDVLf/L211pI+q3+P/wTvgsBZtifcJUF0BaGvwNmQmU3i347x31SPxXgmDppqPTgUXgahq5le0PCCgoEp0q9KCMIdiBpoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ppuWf+ab; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ppuWf+ab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EB34C19424;
	Wed,  8 Apr 2026 08:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775635692;
	bh=fhX++rvzqd4J9wJ/7i4nHR/JYmKqpO83zomoZBI0+4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ppuWf+ab7B6aL7j/qPLcUOu78B/qY/UqY2QAJiDggrMSA26ybXnk5nALqCCPNK3Ks
	 eNYaVemLCAjFeBBeNulCrsuS+B40NCkQyV2q3ap1vU/wVoS+IbepxJCLixGJeKn9wL
	 dzbfvsQvfl8RdMwWjafdlPZ759DpTWkDrqobTTJwD9gjqfBDF0bkpZmG09LCAApB8U
	 ghSqqFC5rn+FpTdrWZPAQi6N91/eARnB9he7m374YQInJXwx7osrcPTK1XaymfcUA+
	 LhGNe8Dctx5ZdEnLnpTwZcrO4FwmzDNatND/18R6nJGiHvn5GusCestPzdhWGNxBW5
	 79QztCe0EnS8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/23] perf kwork: Duplicate IRQ name in
 irq_work_init
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260408072601.210837-5-irogers@google.com>
References: <20260408072601.210837-5-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Apr 2026 08:08:11 +0000
Message-Id: <20260408080812.0EB34C19424@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [High] Massive per-event memory leak of dynamically allocated IRQ names w=
hen updating existing `kwork_work` entries.
- [Medium] Missing check for `strdup()` allocation failure leads to undefin=
ed behavior in `snprintf()`.
--

commit fd542621f59f12c7e1282f77ef0817d45c3b81a0
Author: Ian Rogers <irogers@google.com>

perf kwork: Duplicate IRQ name in irq_work_init

This commit duplicates the IRQ name string when initializing a kwork work
item to avoid lifecycle issues with pointers into the perf event sample.
It also updates perf_sample__strval to return a const char pointer.

> diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> index f600037ee4603..dceb9b79aa6ac 100644
> --- a/tools/perf/builtin-kwork.c
> +++ b/tools/perf/builtin-kwork.c
> @@ -1018,7 +1018,7 @@ static void irq_work_init(struct perf_kwork *kwork,
>  		work->name =3D NULL;
>  	} else {
>  		work->id =3D perf_sample__intval(sample, "irq");
> -		work->name =3D perf_sample__strval(sample, "name");
> +		work->name =3D strdup(perf_sample__strval(sample, "name") ?: "<unknown=
>");

Does this code leak the allocated name string when processing existing work
items?

In event processing loops like work_push_atom() and work_pop_atom(), a
temporary kwork_work struct is allocated on the stack for every single trace
event. If the item is already present in the RB-tree, work_findnew() or
work_search() returns the existing kwork_work object which already has its
name populated.

Since the newly allocated name string on the temporary structure is ignored
for existing items, does this leak the duplicated string for every repeated
IRQ trace event?

What happens if strdup() fails and returns NULL here?

Later in irq_work_name(), work->name is passed directly to snprintf() with
the %s format specifier:

static void irq_work_name(struct kwork_work *work, char *buf, int len)
{
        snprintf(buf, len, "%s:%" PRIu64 "", work->name, work->id);
}

Could this regression cause a segmentation fault during memory pressure if
work->name becomes NULL?

>  	}
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260408072601.2108=
37-1-irogers@google.com?part=3D4
