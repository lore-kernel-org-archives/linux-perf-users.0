Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255453DCDA7
	for <linux-perf-users@vger.kernel.org>; Sun, 16 Aug 2026 21:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786914275; cv=none; b=os/+6I1UlvsvwVZkDEgeQVHy0yfEodF0PIsCa09lBQJ8ZdOsB7uVjnC2tQz/01XzCYAPh/XCodncPr4xbWnGkmPKUjlMnkSLYEENB/Bg91ZA3mDxsMcV8prbLjx4Zt2By6VSFikCEbAZMjtznjZB1qA6sCwdvxkx//g+bqKX9W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786914275; c=relaxed/simple;
	bh=dnlRt2PeQanz0t/5qfRKBdJruozQQdh70OLcq5JRzJ4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kaMb6ONnvqp69hDDGAQvAGgs5MnKp28jmjhAxUVm7SpWcKdj9UEInO1Ju06TXWu6QVeM2q5Y3+9RfDYjGbc6owyEQZ+YKgmJCOe4PN1bYGMwdfq0GI2vRyOFJV6dJ3A0LbuOBYgddMb9IyJq1PzowduR0HrbD8I4G+HbpY+r/H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP1aMBmD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP1aMBmD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38391F000E9;
	Sun, 16 Aug 2026 21:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786914268;
	bh=dnlRt2PeQanz0t/5qfRKBdJruozQQdh70OLcq5JRzJ4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fP1aMBmD290QQfev7uXkmDDwaACZmpAC8v6ABxdpY/8WAMnjbw36P91YrkH17HKOI
	 9wskxWO+UbNx9s/uP4+ltYVD5mTDCOG+2epuiBNyp+WPOHtLisImCGuV9wbNd3M6Z/
	 1da6CI+MBc3fIkd1tK4pNdakCPj+zfChnQBhNf2Ym9fdEEE6j8VlRVDF+O8vvrQDmX
	 JTVWo1f/BQymaOwabXk46hLgJATDl4KRaP5dZ2/Uz8CnjGFKVOopnpikX+UpeuqpgZ
	 Q44erJQyhdxGovBSRMwx54YqDO6av0OseHISp2A35ad1TYDvxk/fo1xMkoIoPoUP2U
	 xUfsQWSItT8Eg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH perf-tools-next v2 1/4] perf trace: Introduce kernel
 symbol beautifier for virtual addresses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260816205921.576365-2-atomlin@atomlin.com>
References: <20260816205921.576365-1-atomlin@atomlin.com>
 <20260816205921.576365-2-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 16 Aug 2026 21:04:28 +0000
Message-Id: <20260816210428.B38391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Currently, when 'perf trace' formats tracepoint payloads or system call
> arguments containing raw kernel virtual addresses (e.g., a work item
> function pointer work_func_t in workqueue:workqueue_execute_start),
> it prints them as raw hexadecimal values (e.g., 0xffffffff81234567).
> This impairs readability when tracing kernel execution flows.
>=20
> Introduce a dedicated kernel symbol beautifier,
> syscall_arg__scnprintf_ksym (i.e., SCA_KSYM), to resolve kernel
> virtual addresses to human-readable symbol names and offsets
> (e.g., "flush_to_ldisc").
>=20
> The beautifier looks up the virtual address in the machine kernel maps via
> machine__find_kernel_symbol(). If a valid kernel symbol is found, the
> symbol name and offset are printed without requiring --libtraceevent; if
> the address is zero, "NULL" is rendered; otherwise, it gracefully falls
> back to hexadecimal formatting.
>=20
> Signed-off-by: Aaron Tomlin <atomlin@atomlin.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260816205921.5763=
65-1-atomlin@atomlin.com?part=3D1

