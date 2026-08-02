Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E08242D6C;
	Sun,  2 Aug 2026 05:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785649593; cv=none; b=XY7i5gkTa0qg9xEr9P1FHf6CC6G32xNcAYy2p15hSh4ITH7LeRaJ/JOPvZhHfaED4bDcTNelwMSTB9lB4jzreCmabsHoR0qFiFoybeJd+DnIuFNu+kaDtNOV8zsmQ5aYvZ5Qn5bomikAHaOEMd8HK5QkYYv7Ty0jTiXqOACXzHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785649593; c=relaxed/simple;
	bh=/JloA19mzPWBY/fxdieSxS8gZqMvtgLEuofchPADLps=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DcY23wtbS/2NBU2u818D9po7uiC8iMaEz6Qq16CuNYZfnd+onIohO/X40ZvX2Zd9+WqiUJWbPtAfv9UDbGO6yf/pE+6btNpiMeNGNHRzW6bzvVbcmW/zi0A+oGdLMoorvzVPYSOAurz2LsfR8gU3/WH5w1ko34QecKMLMFn2UYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiQ3ULIO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiQ3ULIO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD9F1F00ADB;
	Sun,  2 Aug 2026 05:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785649591;
	bh=v2F8Ha4quoZE9e8uqBd/PwJ5rm2wE5GUgH6eBQwnUvs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=DiQ3ULIOYulCSOM45NU4E1FHlniZecnKMs0okPPDMFm5pyiubC7cJdHprP7IwSVSA
	 20V+lO4YzRw4ubLdj65ace/8UdK2/tUHtskJ3BdSWQjGseYmrqPYiG4w/g2dcQlAp6
	 Iw6NRt1IyrmNvjeF5mvuL6kSwFtpgketefHexKtjl4ohqDCNnnLljM/Eb9aCB4ADIf
	 xME4Ng7nBrQY5sQgRa/MEdYLXbjOQ2bNlaicCDX1xGABzPYhWK+1mlEonAHq2GwlCo
	 8l8n2TyjTPZVB0c1Ao5R7dbZPcYUyzKKGPJfCYKS3ZwwwgJ8S2Zl7p1hvhSwoWHYy7
	 6Req4AqTWG1YA==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Michael Liang <mliang@purestorage.com>
Cc: Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, linux-perf-users@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20260728204215.327318-2-mliang@purestorage.com>
References: <20260728204215.327318-1-mliang@purestorage.com>
 <20260728204215.327318-2-mliang@purestorage.com>
Subject: Re: [PATCH 1/1] perf libdw: Fix outer-frame name resolution and
 spurious "(inlined)" tag
Message-Id: <178564959160.665203.11205263654322678583.b4-ty@kernel.org>
Date: Sat, 01 Aug 2026 22:46:31 -0700
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15-dev-c04d2

On Tue, 28 Jul 2026 14:42:15 -0600, Michael Liang wrote:
> cu_walk_functions_at() calls libdw_a2l_cb() with the containing
> DW_TAG_subprogram DIE first, then each DW_TAG_inlined_subroutine
> nested inside.  The callback treated both the same way, causing two
> bugs:
> 
>   1) die_name() returns the unqualified DW_AT_name, so every C++
>      frame lost its namespace/class prefix (ns::Class::method
>      collapsed to method).
> 
> [...]
Applied to perf-tools-next, thanks!

Best regards,
Namhyung


