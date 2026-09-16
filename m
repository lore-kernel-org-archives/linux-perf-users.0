Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC6C4AB3C6
	for <linux-perf-users@vger.kernel.org>; Wed, 16 Sep 2026 16:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576894; cv=none; b=QmOODxj+85zbhFkCV5Wpp9Tz2D9Fw/hKuvZozZzIg+RLvUET9XbosrTFd3osi3JROMSewWL2JuW48Ixoh69u7kbObxn7MGoYORNivluyB/GL4ZukcXiBuJmh1bJ5E1Zop31409CQ9M4jhk4KqeCIBUfXQMA+rdg9mhuivvwG08Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576894; c=relaxed/simple;
	bh=ry504jtCHpfEp8qiZDvdJHz9MUvi090umNVvRCXlfOM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tr2JkzCc4qjW/QLRIvxYZSnQg7PzzSZS1zjzGwYe+koN708rc1xzkWDVtGTwhfqiafYyBPePJPawFGghzzLzG1cXR+IkQGAW5roRz2Ds5jUzLfSZGQRe4jTJdUEsD2qU9Ak1WNi6LUi1+QTOCNcPQtEZNpq61Vpr+TsrZfsYFpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmVOaiHN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmVOaiHN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492551F00898;
	Wed, 16 Sep 2026 16:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576880;
	bh=ry504jtCHpfEp8qiZDvdJHz9MUvi090umNVvRCXlfOM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AmVOaiHNTn5FZ/IOHKZXrcK/TdeAcyo9fYepWnxICA2h5V6o0Bj1X1RNMfAErS/xQ
	 ZIGP748SU7GCTaFSSVdyLB1XwSFhvdxIz+jlK2QjIw6nuNDI0av6ezrbmEHijT+9YY
	 mOkOYaEvtx7+J3ClFgdhh48791hwGUgTYiKZgc/H1H//s33WTpA7mkTlS+0/zjPnv0
	 Rlbf3ZNZUOM5KjQ2HHeUKWJ0oVqsmO4VBLRkVPCn74cMPLzlqevHlon+m/46fpLgOp
	 vDcuAMqAdr7zoTciva5LrW3Yo224ludoZWL7CqzLMth0oqH6azYqCpanQemZ7u/kEn
	 wifT71NDM4jrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 1/6] perf mem: Fix size tracking for mem_lvl's in
 perf_script__meminfo_scnprintf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thomas Falcon" <thomas.falcon@intel.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260916163127.318885-2-thomas.falcon@intel.com>
References: <20260916163127.318885-1-thomas.falcon@intel.com>
 <20260916163127.318885-2-thomas.falcon@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 16:41:19 +0000
Message-Id: <20260916164120.492551F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> When printing memory info in perf script, the entire size of the
> buffer is passed to perf_mem__lvl_scnprintf() instead of the remaining
> size. Pass the remaining buffer size instead.
>=20
> This issue was detected by sashiko during an internal code review.
>=20
> Assisted-by: Sashiko:gemini-3.1-pro-preview
> Fixes: fdefc3750e847 ("perf mem: Print memory operation type")
> Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
> Reviewed-by: Ian Rogers <irogers@google.com>
> Reviewed-by: Namhyung Kim <namhyung@kernel.org>
> Signed-off-by: Thomas Falcon <thomas.falcon@intel.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916163127.3188=
85-1-thomas.falcon@intel.com?part=3D1

