Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63023B19B7;
	Wed,  5 Aug 2026 18:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785954497; cv=none; b=ju9qyOVRdXSk5oHtirYlvQRpuT3hu0tJteDVmGvMRGLIhCbvURjK1GlEjtRDh5epCHLmbop/MZM6JJXqYQWIhnr9cqjbTalqr1UMg8sMHboyacPNmDCjVots1Ms/FuEt4A9pdGVfU8PqTGr6N0xrxGv1iLf7ze4EpfhimRfW118=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785954497; c=relaxed/simple;
	bh=F6Ex5BR/lax1r1YGou6YZuhwBvMn1TJb9QvE5mRqzoc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Aw+INdBzwhv1Ca2AUZLmDq3VuOLYg5ygIrEdsjxWIza3CFawPyp07Bk9xAhmYR+9wnF87fkuWLCv4JQnJZnNLkraSNl+grxJgEjL4fsOOBu7Bb8GGi+yeyfrjl2woubohlJgz8ijZgnmXdwiYfeX1He0oMI7U6jGtR5VnMpCCrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JH8nzIw+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JH8nzIw+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE9291F000E9;
	Wed,  5 Aug 2026 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785954496;
	bh=trQusJK0IN3StuqDFxND+k/Upb/FU0AKfR2rioKBdP0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=JH8nzIw+G8hRT+d9FVKujB9GUZzuvHd7ie620uHOJjsi0ctm7Iv01/hJBkg+VdWkn
	 /uJDwwAYmnvnlzuS9Hdo9pZC1sarPiwx/L96ccok6LsaifoaWX/dwTSLLy8hcbUjd/
	 feF3OCWtx8sCQySIA2HUGXrZVz0wjZxiTIvSH5RapjxKBXJ13ncOpDRw6q9Er1VotU
	 N2HzZEtGMnlgkNdfGdnh8dIBR6PRRWzbt/4yzqy6Zri+c++Yye1mN7Oh0fVsPo6WO7
	 4T/p6fyilvoogSmsgC/2IeMHlm4Xbw9WFHa+iLd9RZgE0P/3HD2PBwfUpykxajhcln
	 PzMBOoRop6a1A==
From: Namhyung Kim <namhyung@kernel.org>
To: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
 Chun-Tse Shao <ctshao@google.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
 adrian.hunter@intel.com, james.clark@linaro.org, afaerber@suse.de, 
 mani@kernel.org, dapeng1.mi@linux.intel.com, thomas.falcon@intel.com, 
 irogers@google.com, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260803215028.834556-1-ctshao@google.com>
References: <20260803215028.834556-1-ctshao@google.com>
Subject: Re: [PATCH v1 1/1] perf vendor events intel: Fix Novalake CPUID
 regex in mapfile.csv
Message-Id: <178595449592.914389.1071192106106385627.b4-ty@kernel.org>
Date: Wed, 05 Aug 2026 11:28:15 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Mon, 03 Aug 2026 14:50:28 -0700, Chun-Tse Shao wrote:
> Based on offline discussion with Intel in
> lore.kernel.org/20260715211144.3144895-1-ctshao@google.com, we decided
> to drop the leading zero from Nova Lake models 0x01 and 0x03 in
> mapfile.csv to match single-digit model numbers without zero padding
> (GenuineIntel-18-[13]).
> 
> The updated mapfile entry was published in:
> github.com/intel/perfmon/commit/00167baed45ac3b2708e89dbf1b9ce4769e9d115
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


