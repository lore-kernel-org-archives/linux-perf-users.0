Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D31A34DCE3
	for <linux-perf-users@vger.kernel.org>; Mon, 21 Sep 2026 05:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789969541; cv=none; b=imhmRYDvmh29Y+lnDzW5GqIUIwJ9PKTfJRUZWuG/We2t1FQ5ZsuLAxsJARCI1Rxihxz0hxacOw+wqoqlCcoDpUEOQ64Se88o5jrE/0mieprO/PN+4B4CccirIKZhVYzGvGZUVI1i92IOiqUOinVJh/nrR2SvFMxxfjZtsJ9ihPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789969541; c=relaxed/simple;
	bh=4GrKc15NSaVHFSHgdHnR+JSD3tSnDWv7cJM4U8KhERQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LDX5MK6hKxjuBgTlDytC5Qe5YtJ2IbnMurtiDXnZYTQgGGJ2rlnrBkOQKtSg2CxdhnHnKuwoyYa7hgYy7WAVTtR2e+Hh4BW7igLfbBpd4NVDnRg4MZyt0Wd7//HEhXKuDQfod8ysouQK4RLRBL4d5QDZmlAunOY37QsNT2vMqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRlWVNWs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRlWVNWs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA44B1F00893;
	Mon, 21 Sep 2026 05:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789969539;
	bh=wxEUFG/7/LfjcgmZaXkkn0e7OqudL7SdOEbZdorwE/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eRlWVNWsWflUG457e18DXL9OhTovvSiv0L9qaQ64GOPoMRWoMST+fHzbEQ6tU7xXq
	 APENby7Yeoxuz+HBd77vEObSFdDowLSCZ5xvBEgMyj0wA0jKfCic04Rafdt4P6FFG+
	 VBsnP933TA7N0pw4oVR5x+7cqGmU63c/56ewpWbsN9NMNyM3ay3sQEs8uUjx2Z1B4/
	 kZhzojGZIm0NCa6SUttbamIfoH6GCg55hG6534VQdjwOQ0kRqKULmi4iXcFqnYolIv
	 7aS6AJbcASsVTgnKDeRjSS+Pgh2B0TtUWOKdE2u33oN0Q+Bvw19DxoUpi9Yt3RL/N/
	 EX3jxt7JUONTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 49/49] perf Documentation: Update for standalone
 Python scripts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <d99f080f99e312b0a6a34b3752b8e14f5aee0c93.1789966896.git.irogers@google.com>
References: <cover.1789966896.git.irogers@google.com>
 <d99f080f99e312b0a6a34b3752b8e14f5aee0c93.1789966896.git.irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 05:45:39 +0000
Message-Id: <20260921054539.AA44B1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

> Update perf-script documentation to reflect standalone Python script
> execution and the removal of embedded Python and Perl scripting:
> - Remove documentation for the removed -g and -s options and legacy
>   record/report script wrapper modes in perf-script.txt.
> - Remove references to perf-script-perl and delete obsolete
>   perf-script-perl.txt.
> - Rewrite perf-script-python.txt to document writing and running
>   standalone Python scripts using the perf module.
>=20
> Assisted-by: Antigravity:gemini-3.1-pro
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789966896.gi=
t.irogers@google.com?part=3D49

