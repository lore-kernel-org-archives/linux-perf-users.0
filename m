Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B866157A5A;
	Sat,  3 Oct 2026 08:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791014534; cv=none; b=MrKNMO6UuJ0zre+12iWL7VfISNYEw72LIjiCVjLTJ4Zv7ZnQ9sShUBebtxHRBAI7f93vts4s9iPxL0xh/w9QOHTc7KDa4ARnaKz2O3mRZLMwFCG1QGl6YF+r24+S5GsM9ts8PxX+SSZPbawrcgbioxqWNbQIP5kZa5Yj+dW2g4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791014534; c=relaxed/simple;
	bh=buf4p4PfGLHMAJaLMeHJrtONO05FHSmH3ATFan8k1tU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BsvJw2V4V9dGyzn2uIgo5X8JClsXG6kbwxVFrxUTMB5s5Z3plZWPGUp+SF11XzkcGP9qGlsWTzTlnS/ycsVVLDGAaQTK9SgpGsA7wOcpHjnpKVsXckoBV/l9nvqkb3zcTOrUa/FjLYIlvJGCm1PvPomHzFWFq71OOfZNFVxTRBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=df8rWbj2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="df8rWbj2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BD31F0089B;
	Sat,  3 Oct 2026 08:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791014533;
	bh=buf4p4PfGLHMAJaLMeHJrtONO05FHSmH3ATFan8k1tU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=df8rWbj2nh5YfP2+w2Vk/orNAqR6RD0EuVY/ZNd4fFCJC2WbSk1b1Z6BOBvCu8ZHl
	 PBqWqJ9s84ykB5zdB4axjhKCPxFIc6Y/Hd5Kfdant9LBXHk0joaPVWag9bNwUotCQL
	 q4ngWHHWadGU9fTmgIFf7DZ8aYV74F3INUjQ6v92dOQ8h1/QbyXCTd9M8Hw88Pcciv
	 JKIlZErS10o6l/g8aVhKhMFvVWR1wSA84vPdngDOeYjXsqSUuhQ/0PZ6EefmHeo6Hw
	 0AMyCyCgCiUJYGARIW6hvnMbT86iJn4HLY2nQ8W/IJIjVt8zE1F4d+zGshCQM/r0bJ
	 moxX1Xn77faEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v19 11/11] tracing/wprobe: Support BTF struct offset
 resolution in set_wprobe trigger
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
In-Reply-To: <179101406102.22872.9377441683742556335.stgit@devnote2>
References: <179101393469.22872.5895666191299551553.stgit@devnote2>
 <179101406102.22872.9377441683742556335.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 03 Oct 2026 08:02:12 +0000
Message-Id: <20261003080212.F0BD31F0089B@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Allow set_wprobe trigger to use BTF struct offset resolution to specify
> the target address field.
>=20
> Link: https://lore.kernel.org/all/59637b96946653393a7ad3c7de094094796b39c=
2.1785067572.git.wangjinchao600@gmail.com/
>=20
> Assisted-by: LLM
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179101393469.22872.=
5895666191299551553.stgit@devnote2?part=3D11

