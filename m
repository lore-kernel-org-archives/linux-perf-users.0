Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BDA372ECB;
	Tue, 22 Sep 2026 04:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790051548; cv=none; b=LRkVS6UWVzKrpVUkHZ2kZZ95MqtkXRBczHMbl4uYCslj+WcWV982VzxKpGZsFL9Y5cOoJtaawJhzuhm472+jksMIvTLlMJrKQbC0CsYpTBOw22zq2E2rFOBtt2FIOdQt7TqaRPygNov8gNfW22Qp3/S/IRoZY+o2+vIY7rI9bzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790051548; c=relaxed/simple;
	bh=wnwAuhpckhGFVlRBTbY/BTyOAPQ8yfUxE7XflVjTw1E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mykq1SO//GBlV98Vc7JlQt3zm1JQf9GV4w6honX1+UHb9KZq00i7V9+Myy8KQdHX545HDnPqPviZygJlsvk5IaIO/o79jpkCamBf442Pn2zJS4HybcZRO4Kjq22hwjUdfRXfV+qXkC9yl1Stubti+aNM3c39tjy/dkPVcanb9WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fozMd46s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fozMd46s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA9D1F000FF;
	Tue, 22 Sep 2026 04:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790051547;
	bh=wnwAuhpckhGFVlRBTbY/BTyOAPQ8yfUxE7XflVjTw1E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fozMd46sJjHOdjAx8v17Y1ewO7g1NPWQcbSauMvPRSU1ieV/mue5yAZcXZqjhEWWk
	 QQewpBqrJBHq8kO/wSMs7Ew//wWRcI/i3j89u5yHUbT9w5E3z91k0+EMZTGe1jSUFx
	 q5KB2i/hCT0gLwhcwpXStepYDl3/EtUNRzkOPjOqQTZye4rO1heVspYPmf3KS8esmU
	 zDRD+ek//0riqXvcPYgXULxo0utfH2dB8RM6UNZDMRGNcYNfdjaGpJrwhfoXx3S7Kd
	 cOpi0FrB76i//PjMRi9lwpEOOpqPh6dyKISmVszIEPfHh3uYJ31lhe+kNsKeiWUPeQ
	 XSnIo9mIm+gfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v17 07/13] x86: hw_breakpoint: Add a kconfig to clarify
 when a breakpoint fires
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <179005116728.388919.1381770935956884195.stgit@devnote2>
References: <179005108298.388919.4535333252892590932.stgit@devnote2>
 <179005116728.388919.1381770935956884195.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 04:32:26 +0000
Message-Id: <20260922043227.0DA9D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Add CONFIG_HAVE_POST_BREAKPOINT_HOOK which indicates the hw_breakpoint
> on that architecture fires after the target memory has been modified.
> This is currently x86 only behavior.
>=20
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179005108298.388919=
.4535333252892590932.stgit@devnote2?part=3D7

