Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F93909A4;
	Sat,  3 Oct 2026 07:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014396; cv=none; b=Q6wygYBiXx/2xHjbicHzR8q+un+XsAX4ijCkcpa898JIlBTuivXJGRjmBDEQcHs0hXTXZwYk55jxPOli8JFgOJZZHPr7I7fbU91XbB/fDUGHS6QB6p8WoNoaC065YFMSFYRoknKDz2/BZx0ZroqMEGEIkXqV+KMSmX3wAFRO7VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014396; c=relaxed/simple;
	bh=uzZkG5kw6oIIxftQ5OtuxftrROrHnvNC/NPqQqpyAa4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aygK12Xi52bTeWGle6tVEPNNpTMz4U8kqgZPb6QsH132homaBMucnLkcgoHnB1EKFiYJFdKug9EnyZavXqok5qO6TuWiLQf3kyiBPpmXzp8PJMQK+P0M6H0ETyaljbGiJ76odt3yaztkyRdZJFGl+aXhgMNUht40/wuJf685Lww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cWlkChYI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cWlkChYI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6CCD1F0089B;
	Sat,  3 Oct 2026 07:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014394;
	bh=uzZkG5kw6oIIxftQ5OtuxftrROrHnvNC/NPqQqpyAa4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cWlkChYIopLQ/ej178KcgCgt8VmcjEuH1tYfEMwD2CNA7ijfJzV5amQdhEpmb5+5k
	 D9vfRT21I//KOxJnk/gwGKNpLj69cL58RKUMbRsFd7kNT1O6GtRbXlqRl9o6gYH20P
	 +SfZGQC20aWpzKQVxA6jJOsbK5Kbj6TdLJJM1Lyt+Ghk2CSL8K1/lwK5hHiva/lI9E
	 5pS+zWmfbgl+qWN9mybH8YFfi2J4JPPyBlN/YdJh0wjK9Fk9mFnExz79mWRn48pD0N
	 voBM3+czFymHWV+fgWxE1Q5u7jjbPYM7NurqPlWZXMXJPpJpovkP/7TREYd74DJxIs
	 qeKutWvK9CFbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 06/11] selftests: tracing: Add a basic testcase for
 wprobe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179101400276.22872.8093489412579904892.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101400276.22872.8093489412579904892.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 07:59:53 +0000
Message-Id: <20261003075953.E6CCD1F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add 'add_remove_wprobe.tc' testcase for testing wprobe event that
> tests adding and removing operations of the wprobe event.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D6

