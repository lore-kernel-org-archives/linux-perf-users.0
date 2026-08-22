Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E953A785A;
	Sat, 22 Aug 2026 09:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787391109; cv=none; b=iEho+YtMcC6GsSfOTTbraKuASqFw7kutQSRLiyvTcJiC7HaierfTiRgsIGY5kUmQDgWjLefKvpC9Q3S5RlYhctW5Ip5TPVbkPmUon4i2I/LX1syx7piZHfGtB/8zsnO4pBZgMIL+DIQaT8UvYKQtq1f61CIOtjKDkVTxrmExpWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787391109; c=relaxed/simple;
	bh=+A1qyPRNWxe7RTjT72iiE5J3v1QpdkN611uFyMhNBQ0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IWzA+6oQ3YPfyHYSq55ocHk2ZLWrtPzyOBzajvmfmq8yu7pAogp/5uuflbN8GqvBzilxMH1dyZTVosYDjQ8xDctX2tboMmlLTGyCFIdaf4gjplOA1bWkVNc5EmQEZKadAdUC/sWzN7XghMUmo6tMyVg+NJCQU4xlr9dFKBhmt8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBksK9FV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBksK9FV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE5A1F000E9;
	Sat, 22 Aug 2026 09:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787391100;
	bh=+A1qyPRNWxe7RTjT72iiE5J3v1QpdkN611uFyMhNBQ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TBksK9FVvamgNkifzqRpGIiMfPG3qhsPi9wu7eRRvuKzolEMGWYrnuvpzfMMtg6NV
	 ErUzNPS6+0q+F0o7M+RAyIFS7gfKeCksVW8sFBC7nI6C64KAGXQBaU/TgwFJutUdhe
	 3JP0LHgXg3GalwayKt8+hZ2GlM5s5Iw4tl3/5Xr1qUDAWjSA0nyC+x+zyAgybtuck4
	 gbLSLXEC8dWArPjLJUayM4blfpiCT7R0FO3QHpZ7rmXbi9Zl7OfX4XYG3QqK/Bnjjp
	 9fbGTat6jXG87Z6VKdzKwMQXfZG7LZpVRcatqm2C+tUpBytXF3Nr2gPU5K87FxZUQM
	 Vt6Gjz2ikaycA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 01/12] kprobes: Protect kprobe_blacklist with RCU
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <178739055104.1520941.17729343305722017231.stgit@devnote2>
References: <178739053919.1520941.17662338993878200834.stgit@devnote2>
 <178739055104.1520941.17729343305722017231.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 22 Aug 2026 09:31:40 +0000
Message-Id: <20260822093140.7AE5A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> __within_kprobe_blacklist() traverses kprobe_blacklist without holding
> kprobe_mutex. When a module is unloaded, kprobe_remove_area_blacklist()
> removes blacklist entries and immediately frees them with kfree().
> A concurrent call to within_kprobe_blacklist() can therefore dereference
> freed memory.
>=20
> Furthermore, within_kprobe_blacklist() can be called in atomic or
> non-preemptible contexts where the sleeping kprobe_mutex cannot be taken.
>=20
> Protect kprobe_blacklist with RCU. Use guard(rcu)() and
> list_for_each_entry_rcu() for traversal, list_add_tail_rcu() for
> insertions, list_del_rcu() for deletions, and kfree_rcu() to reclaim
> entries safely after a grace period.
>=20
> Assisted-by: Antigravity:gemini-3.7-flash
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/178739053919.152094=
1.17662338993878200834.stgit@devnote2?part=3D1

