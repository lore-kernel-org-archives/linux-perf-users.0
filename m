Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AAF3E3C5B
	for <linux-perf-users@vger.kernel.org>; Mon, 13 Apr 2026 19:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776109598; cv=none; b=luz3E4IffVAzgIuV6AsNPOkH93F413ELPiIZcDTdTfGfWf48HLXi6ITSQD6NC2CB6ODhdC3eQS3l1FAakyAEy2qyqNwg/5xU/iem+WvmV7tmEteWJo22y8NdV7jHptO6YV1RnqDVTMHfAGexsUV67ajKVyL1oa9Ud2v843epvYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776109598; c=relaxed/simple;
	bh=U2L3Xl4/5x4v5ZehhhCXwOJiZkZWzhmSaUzUI2BPXn0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P8OvqUz3w5n6vbTJ6iBSrPaO3d7gGzrFBa8oz/7KgSlIl7P0SYOG+C9okb18vi0lDdQUqQ2Zvn3fny+IzYXSO75wXxnld1gb2NtykRjU8Hcgw2MSVukGxS0SAo5QTXmMv91ijMT0ldXg2pmn1KoSPWLxwQRXJ8OdzmsXkfmw4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LEKWfA1e; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LEKWfA1e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2086EC2BCAF;
	Mon, 13 Apr 2026 19:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776109598;
	bh=U2L3Xl4/5x4v5ZehhhCXwOJiZkZWzhmSaUzUI2BPXn0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LEKWfA1eaRIumnSBmheT8mHquEpkwaFVxnvs0afh8SPkepQX87IkeCGqpF/05Rj7X
	 Z9mXe9GQr8qfyjpmLjn1CVXVBUeJSioZn3Ink5ojvsWJ0Ui8MZeHeNNYIqyQLMVRAD
	 2T+W9ht53Oc2T8SbtWYNWZJXsJu59/RUSyg5RFPCcuB9iKWGpKO122PgcuaKFjB9DO
	 eBUSaE5txRUtmKvg8kLTMmW0ERyQLUWvNwK/0baPZ62xZKLAZW6+bzmOHk8k/jYP/8
	 85UCi1cpiTS+C9knjW0sAd8YcT4hQUVLHFvrtksep18ORfj2htywiosW6rByxfGEhU
	 6Q0a7ZeZjVDUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/4] perf: Use a union to clear branch entry
 bitfields
Reply-To: sashiko@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260413185740.3286146-3-puranjay@kernel.org>
References: <20260413185740.3286146-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Apr 2026 19:46:37 +0000
Message-Id: <20260413194638.2086EC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Low] Missing tools/ UAPI header synchronization causing build warnings.
--

Note: The format of this review is altered and does not contain inline patch
quotes due to automated recitation restrictions.

commit 0f3b756dec935106f8ca717cac2777f750f3b8da
Author: Puranjay Mohan <puranjay@kernel.org>
perf: Use a union to clear branch entry bitfields

This commit wraps the bitfields of struct perf_branch_entry in an anonymous
struct inside a union, allowing them to be cleared via a single assignment.

The patch updates include/uapi/linux/perf_event.h to introduce the new
union and struct layout for perf_branch_entry, but it does not appear to
apply the corresponding change to tools/include/uapi/linux/perf_event.h.

Will this discrepancy trigger a build warning in the perf tools? The kernel=
's
tools/perf/check-headers.sh script explicitly tracks this UAPI header. When
these files drift, it usually results in a warning during the tools build
stating that the Kernel ABI header differs from the latest version.

Should the tools/include/uapi/linux/perf_event.h header be synchronized in
this patch to avoid breaking the header checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413185740.3286=
146-1-puranjay@kernel.org?part=3D2
