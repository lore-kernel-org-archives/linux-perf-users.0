Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350255;
	b=11XcF/YzwM4It1jQPR7IXkoa15+Y9zB8ea5bcQYVan68vS+o9a3ZxI2p6fOjoFFNnth1
	 kbTgGbX0H79AisJm/tIDjPL/BGcz6lxMoWuPlXaNx7J41mn4vRtdEBbD2vFjNz7TgISGU
	 rCckTUrshvwNz0wKm2Cf9dFLmcILU5uZJdOMuvTKxFBRIYA3oMhujzYQhG/SDtbv4M/Pj
	 21r1grod5zoX04EsojlDBz0lXJeYzDRP+aXqu+uFNXnyHr9hSkbKF4/orMmhL6Y8EZ0Mp
	 1l9H1EEVkxhtTuJ3pfXCVDJZFzAcLHMcUbDtDTIdFi+dhaPIAEwXSSHDdWccBkqMXzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350255;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=NttlhD0D9F2H0qOg/BS6wC/u3+R5sWr5ev49D6+QeKM=;
	b=fmRJaCZTpueV/DT7P58parFtDon4PZN6Cg7eVxKvW/rClAgg8TH9nWAViu9WX1aYtCTJ
	 LTXq2u8r+UOder6f0z4PSrd00Hd3hV9rJgQD8dtMjuHPZqGKWiFEB6gQqPGrFQjUelv2b
	 oDoiL6p6TLO2xD1SWE/aiZNjtCsUkf7Qw/2LXu8RzooQHFFY8twecossowZlI2BXq/J0g
	 flvach7RntDisFd84gWAhb3ObW8Ir1Nyg2c53hDsMiFsuAkPYD0lmDSHFgEpuWe1cPeve
	 55ZMhxrJF4Ey+jUAH5yTgbhv1jmjX4Wun5V1G3cZIsdO75b0ClFUE48TI0wA+sN1X4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGI1Cmqp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11C6606A31C
	for <linux-perf-users@vger.kernel.org>; Tue, 10 Nov 2026 22:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AGI1Cmqp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D78D1F008A2;
	Tue, 10 Nov 2026 22:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794350255;
	bh=NttlhD0D9F2H0qOg/BS6wC/u3+R5sWr5ev49D6+QeKM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AGI1CmqpAb8NeVSns59gWzT4YU3/dUscNw4uX7rW7GzjahHdvJaHT8QpjIlwEYMa1
	 sQMNO+MPtXw5bvhtIs+WueX1AhMyVXsPwdpGjI9hlsjJfWJch+Waaos5uC8jqfZPdp
	 ELh/SL76Ts4b2/nnS0dYUIcKsRmKLGUKzoxykhK1Y/i+k6WqdwBYupManH1eMbb4MD
	 tMD7Ccw2e6JOOh0XBfWuyl0tWcwhuMeuGHfUOXWjcMgkQK0Fo2K41bZ2ckp2dR6M8W
	 gjUwLh1l5aeMJifkGez+zoGLfevtz68H49VyNEkwpFKhD5j7oXLkfXOXifZRtGdbYx
	 Oj/Pr/0XD5wkg==
Message-ID: <sashiko-outbox-207837@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/20] perf maps: Optimize tail insertion and
 small-append sorting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20261110220803.2503416-14-irogers@google.com>
References: <20261027231513.816148-1-irogers@google.com>
 <20261110220803.2503416-1-irogers@google.com>
 <20261110220803.2503416-14-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 22:37:34 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

> User-space map insertions (from /proc/pid/maps synthesis, runtime
> PERF_RECORD_MMAP2, and jitdump) and BPF ksymbol registrations all flow
> through maps__fixup_overlap_and_insert() -> first_ending_after().
> Currently first_ending_after() has a fast-path check for the first map
> (maps_by_address[0]), but no fast-path check for the last map
> (maps_by_address[high]). Because /proc/pid/maps entries are synthesized
> in ascending address order, every synthesized mapping starts at or after
> maps_by_address[high]'s end, yet currently executes the full O(log N)
> binary search loop. Add a tail check in first_ending_after() so
> non-overlapping ascending insertions complete in O(1).
>=20
> Additionally, track the sorted prefix lengths (nr_maps_by_address_sorted
> and nr_maps_by_name_sorted) in struct maps:
> - In __maps__sort_by_address() and maps__sort_by_name(), when the
>   unsorted tail is small (k <=3D 8) or the total map count is small
> [ ... ]
>   After (-6.9% ascending, -98.7% append):
>     Average ascending insert + lookup: 58.970 usec (+- 0.609 usec)
>     Average append + lookup: 96.670 usec (+- 1.353 usec)
>=20
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110220803.2503=
416-1-irogers@google.com?part=3D13

