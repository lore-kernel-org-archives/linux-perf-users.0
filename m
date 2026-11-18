Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795020034;
	b=RfmJ73C2BNv4TJ/hbPjA0wLt7Gb+NPiwWIEO5gnRto93Kgk6/sK+3owru+zJWZwW3Gth
	 ot1iS3RHiOlTp1iGCVqYEzkDEfBTSvtVbR7nVCDEQW/6nwIEaiRFVwUW5ytsFDLJ+p+x8
	 MG0tkq5kqHqSM1b7nWsDUjl6OTPmq8ODvDqnxLuLm5WPU/jTIh95rmbaN6b1Fidb8U8DE
	 qNvhBaoh40mUBrMKUXhHus7op+iB9Q2juRMHxNAHOrN2WXksuOTptOcj/5bl07g8jWJWY
	 qDD30LyIl9L8EfPEqEoKRpcp6vKKWv5qqq67QObWbWKcsykWVIZ1EC5p/geFVrQ9i9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795020034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=RjeuckGSds15/lqZH+Vr4ec5hruLPoz/xeNvKeKqoSQ=;
	b=N6YR0kdWux4qz6uiMvund+ZL6ZC7MSfx5+pKhVxYqRQ6ERJXp/2/QVHK2LvjwNIiuBkW
	 rRl+pzfgdIdzWLHfSiBokulbl/UvDjCa63+U81Qsgf0Nw+oUM9d58veSloi7hXPquu2xe
	 tlshUbrv7Vhl7oiZqCG822/fAEyAlgoG0sQYH/K13obqJx6G/borOUbitS0A6VwzWcJHZ
	 ZRMxFMorF7iLLh0haur8jnz1JtfjtfxiPmLVrkK/KTBkreT2R7RtcjPpJBmGMPgVyidOD
	 /oNng8rPDuhSVSYBxvlXvObgdzlryCFK0kemXeSpXcYgDmxQePistJM6XEfoikEwfOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmUxGT3J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C1606A33B
	for <linux-perf-users@vger.kernel.org>; Wed, 18 Nov 2026 16:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmUxGT3J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7E31F000C4;
	Wed, 18 Nov 2026 16:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795020034;
	bh=RjeuckGSds15/lqZH+Vr4ec5hruLPoz/xeNvKeKqoSQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VmUxGT3Jc+nw18pQmDBrW4u4uH1clNlGzQvM/HEIOcNEPnYLSG0H8LNHOx8IBmqgn
	 +6C7/0RGnnUSot36aQcRBV0M7YBHGpMohWqLaF2bm/nt+cAB6OMTe2eF8bnpptdlqV
	 I3j8xeCSr5QvPQ67s9NAT/+tcbcBdUH1bdi49ghK2OUZdHU6q6SvlY7Z+K8ZgF3wb/
	 QC7t3yL635R80d1usaf1+cRwg+BhBNrjQGQ87Y+6brm5yWZC/yswMttzqXgIz6L39z
	 tj3RU421wO8RSvYqXMH2nDnJRzSlynw1V6esiiD5WeRCnhqbQk8cySxhGQKiapcYdG
	 7ZEqbxkHCFSPA==
Message-ID: <sashiko-outbox-221523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/34] perf cs-etm: Track sched out events
Reply-To: sashiko-reviews@lists.linux.dev
To: "James Clark" <james.clark@linaro.org>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261118-james-coresight-jit-v1-12-dad4d90747f6@linaro.org>
References: <20261118-james-coresight-jit-v1-0-dad4d90747f6@linaro.org>
 <20261118-james-coresight-jit-v1-12-dad4d90747f6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:40:33 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> The sched in event might be dropped due to a full ringbuffer, so the
> sched out event is still useful information if that thread is going to
> be seen again. Call machine__findnew_thread() unconditionally as it's
> harmless to do it twice for the same thread.
>=20
> Signed-off-by: James Clark <james.clark@linaro.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-james-core=
sight-jit-v1-0-dad4d90747f6@linaro.org?part=3D12

