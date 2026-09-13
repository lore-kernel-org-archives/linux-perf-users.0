Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68079374A1F
	for <linux-perf-users@vger.kernel.org>; Sun, 13 Sep 2026 02:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789267414; cv=none; b=uUBg8bitzaNni1vedZbR1OpG1Q+z9mLooUVfdmWR2jcae5wV6JJNOyKDVF8Yhrg4QDyHjdToq5eVoag0ScKJ6uWxNIAn6F2tWB6SnUaL/OKpYmIGuTzZbrml44fLhN5/SJzUs2h+VZDROMif1GC8g1r9X3YtcqvV+hWdPjrFM3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789267414; c=relaxed/simple;
	bh=4awy3KwnBpXDYMkY0KU4H5uY1t8ZOyb/khCEpH3WreA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=trcK60eAUg5AdmxNFZZYEE/+QMuxV0KHDc1jVVrz/oc2KLKBHLGdaAUTK+6ht7i12CVIiQ6u19bhp2xyczc0XDvxcu1E450zUHbfE67DdqTcSzwqDvaC8jlUHexinZcI0M0NoHPcTWBuPuY0hXbXDTN46OKUxqc4IndNFsjrvxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O/NzGPk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O/NzGPk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17BB41F00893;
	Sun, 13 Sep 2026 02:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789267413;
	bh=wt3rVKLzQVBIM8fBAifrw5wiIXBFPfxGwYgsRdRmzjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=O/NzGPk8lDK2Z8kJeN83c0VuPGMb1mX2JDC8cJy00C+jTbOMN38HSIXcrUFK64vrY
	 CVKR7h3Lt6uh/l+dfmgHioMdDaJpBJDBAaOu4hFgpRmKWNwsbBKSjzRS++63e18ZLT
	 8qFTNM5ZNoXwPFE/uJ7xsuEDZw4fY3dFFHOFyxGUcsi0MQz3iegelkbFh0/NUNc+wX
	 C0X4AIduOBYlox1+Ds608WzKcOVrvVRp4OLyIziA3goHq6herCCcl2Gi0uJIxCB5yQ
	 aMsK8aVGyXVvNGjZATTyMfO1njzKRZ8zeDNzIsS2npvpnvttkJc0k2R4NBLP3JoqSm
	 zmdmyGyHFP2MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/8] perf annotate-data: Show the sample count in the
 data-type browser
Reply-To: sashiko-reviews@lists.linux.dev
To: "Arnaldo Carvalho de Melo" <acme@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260913023459.112654-5-acme@kernel.org>
References: <20260913023459.112654-1-acme@kernel.org>
 <20260913023459.112654-5-acme@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 02:43:32 +0000
Message-Id: <20260913024333.17BB41F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but child nodes and =
their 'hists' arrays are leaked during browser entries deletion.
- [Medium] This problem wasn't introduced by this patch, but there are miss=
ing POSIX libc header inclusions for `snprintf`, `calloc`, and `free`.
--

commit 5a4ac13ab552e8559bedbbcd49a2b0cf582b03bc
Author: Arnaldo Carvalho de Melo <acme@redhat.com>

perf annotate-data: Show the sample count in the data-type browser

The data-type browser has a samples view, selected with -n (or with
annotate.show_nr_samples), in which browser__write_overhead() prints a
local nr_samples variable that is initialized to zero and never
updated, so every member is listed as having no samples while the
period and percent columns for the same entry are filled in.

Print the histogram entry's own count instead.

This predates the load/store counter split, so fix it ahead of that
patch: the split then only has to adapt a line that is already correct,
and this fix can be picked on its own.

Fixes: d001c7a7f4736743 ("perf annotate-data: Add hist_entry__annotate_data=
_tui()")
Assisted-by: LLM
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

> diff --git a/tools/perf/ui/browsers/annotate-data.c b/tools/perf/ui/brows=
ers/annotate-data.c
> index aa8c89fe2e82c..1080ed1a40d26 100644
> --- a/tools/perf/ui/browsers/annotate-data.c
> +++ b/tools/perf/ui/browsers/annotate-data.c

[ ... ]

[Severity: High]
This isn't a bug introduced by this patch, but child nodes and their hists
arrays are leaked when browser entries are deleted:

tools/perf/ui/browsers/annotate-data.c:annotated_data_browser__delete_entri=
es() {
	list_for_each_entry_safe(pos, tmp, &browser->entries, node) {
		list_del_init(&pos->node);
		zfree(&pos->hists);
		free(pos);
	}
}

The loop exclusively iterates over the top-level nodes in the browser->entr=
ies
list. Does this leak the memory for all nested child nodes in pos->children=
 and
their associated hists arrays?

If a user repeatedly opens and closes the data type annotation TUI, could t=
his
unbounded leak eventually exhaust system memory and crash the tool during a
long-lived interactive session?


[Severity: Medium]
This is a pre-existing issue, but does this file fail to build under musl l=
ibc?

tools/perf/ui/browsers/annotate-data.c
	#include <inttypes.h>
	#include <string.h>
	#include <linux/zalloc.h>
	#include <sys/ttydefaults.h>

The code uses functions from stdio.h (snprintf) and stdlib.h (calloc, free)
without explicitly including these headers. Could we add these missing POSIX
libc header inclusions to ensure musl compilation compatibility?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913023459.1126=
54-1-acme@kernel.org?part=3D4
