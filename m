Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375503E5EEB;
	Mon,  7 Sep 2026 03:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788753536; cv=none; b=hdJV9/h7ZpVYxFqZYZYoK7I68NNCgei9U0lW0xKVdiHsbtb6j+NkAZeuCwnfncmuFse03Vj+lTpIT+Wz4fVrKUPIVArEzZTdcfpvuTehwLI0LumkWBgfNUNbRvoe/EhN5BPTb2Upb0u6cdBNcQ93op+YaZFqa8xJ9MpiWq3nnHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788753536; c=relaxed/simple;
	bh=NDaZqwae6b3gQt+HocM12p+eTcw+Msy8aqG3BXodiYU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VArS/TxKxeQ7id68cQf5dpG5IgfGXBjeohjdSH2tidASWFOMO+XoYJ5C0sYni6yh8BMsPibyriNk0eLKv1Q1bOKC4NJva55KKWpRCSPC35A+CBEGZqg3bUyxRZ2l/3KB7y+CUSbk0E6hzZZS8TXnyf+FpGH16UvMF2FnnHKU9cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SY0JXORT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SY0JXORT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BD51F00A3A;
	Mon,  7 Sep 2026 03:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788753535;
	bh=NDaZqwae6b3gQt+HocM12p+eTcw+Msy8aqG3BXodiYU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SY0JXORThTUlJEtFF56XHFQmwO55z0ShntGi3AMjhafeaHtWvC/NtvM0WNUtW4nLh
	 uizCwOJrPXOuXaJoJvlvC25X/dixDr+wv4BS2WBAyblrqD2aITC0ikFdRGtrDCwrZL
	 WGsYjdUtWWYyyR6PCLt6Vd2HSZTcNB//qvLMbGPV5DO+gc8phcuupYU/A/E3aTcap8
	 fuP8s0SNC/f/qXQWOHvqFgQS5XqwhpttUbmO5P/GFZt3+jQiqhc+eXkIfOy1cljjyW
	 sLjXoKFP17SC0vccIgLVS2lf7XZZ/pUc2QyWMCc4SuUt7Ydy/hGtik0BE2AruKhFvx
	 5TVXji4k9NPeg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v15 10/12] selftests: tracing: Add wprobe trigger
 testcase
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <178875289091.93794.11265683859086435623.stgit@devnote2>
References: <178875277830.93794.14247844688761142429.stgit@devnote2>
 <178875289091.93794.11265683859086435623.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 03:58:54 +0000
Message-Id: <20260907035854.E1BD51F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add a testcase for checking wprobe trigger. This sets set_wprobe and
> clear_wprobe triggers on fprobe event and static trace event to
> monitor memory accesses within the trace-events-sample kernel module.
> Also add a testcase for verifying wprobe trigger syntax error logging.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178875277830.93794.=
14247844688761142429.stgit@devnote2?part=3D10

