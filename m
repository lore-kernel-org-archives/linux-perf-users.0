Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795630969;
	b=4/PYz1ioHxgydsCaUKxD0JzVb+FiUL4C+GDDkr854sfHLhd+Ol9ZARmalro1vK1DBBhf
	 JFo97m8xL3mHy7BTiJum5Rg5qh1zbf4fX8CageI6tStkisjF+dxyV2WeVyrCgmsJGH/JS
	 5lWG56UHYr8y7qyvdl052e0jcbggF/+dN82T2LInGuMUu98HfM8UQ6hHiVslJ6VyiUzga
	 Gd15N5JSOhWMePDjZhwi9KXf6ksMN4NycZRgDAa778AuNL8kP8znWuwR12U8M9aLMLHHt
	 WnW3zA4ZAlrjLxPI9PDmw8n3gjHL4BIPajNNcGAZbtaYoJXCZUnNcHH0pLXVUbJGpYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795630969;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2J1VQzsB87BW8DLXcmbw0G/9bucBGY1jjkX13LRsTHU=;
	b=s9QXVI4IOZ5rIBLDep4j+Ul3gR6QGD/z1YIJJECcwxG+GtkC1MdtkOPMOM6MBri2G2ZA
	 P3CSEU5cIBuSaNiw8bzlVdexQDRXT8QYk0KEOAj9NjOL/BhsSqgwFfh0GN/zZfrD7LAYM
	 g6RhlZXu+tVj+MAlEoMdWSAPLQsJiCWDj6jx8E59ZbeIk5RyAhfhcTG7z32pVyJCXIIl9
	 54b2yhkDlwSYu11yI06/gV1DWETAQGmZ/mABP5sStIzfFZIN1gau1KGxoTgeytJXZdOVW
	 UdfJxTXhXl157rEnMHSbyl5Xjs60qLvQQWC6d2C7s04ZIkAOdDLIFlSRSCE8VuuKWsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JONH7iEe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2068606A323
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 18:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JONH7iEe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 006021F000D0;
	Wed, 25 Nov 2026 18:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795630969;
	bh=2J1VQzsB87BW8DLXcmbw0G/9bucBGY1jjkX13LRsTHU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=JONH7iEelmvcb500DjzyMO0PaaMdwPHBBMa2gB/sU/yBc1EDv8gdCjbdWCiVzsm6t
	 mkMB3YAmTUcXT7Az+LLuanq70qNylBi3N2P58ygHxbdoX5/8u10kNkb3rfE2xoF7Md
	 AZs2bi6paee+bUPa7tXNb3IbTvFfz0HF1ybznmelsJlcPiUqahAAkFFG6aRq56oiTT
	 uLZYs/LgPTLmM313u941zUzZTJKO5NyZm5e7wm41zcYg9t+DAUc3R6YvD5HppeE/ng
	 8Ri1QrCUcXdWIGUh1JByPDGrMfta1xbT8r9R6fjXPtyz3r3PEbPTNO42IvDWe7S7rD
	 sIYNQKvA4HpWw==
Message-ID: <sashiko-outbox-233976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8] perf stat: Refuse a group mixing tool and kernel
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261125175450.2373258-1-takano32@gmail.com>
References: <20261125133854.2180695-1-takano32@gmail.com>
 <20261125175450.2373258-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 18:22:48 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] perf tests stat+tool_group.sh: broken hwmon PMU discovery and
  event group test
--

commit de61381e655671f0d4ffde4221e3cc5db6ec0e53
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf stat: Refuse a group mixing tool and kernel events

This commit refuses event groups that mix kernel events with events not
opened via perf_event_open() (such as tool, hwmon, and drm events), guards
against NULL file descriptor arrays when enabling or disabling group
members or looking up group fds, and adds a shell test covering tool event
groups.

Link: https://lore.kernel.org/all/sashiko-outbox-227849@kernel.org/
Link: https://lore.kernel.org/all/sashiko-outbox-231330@kernel.org/
Link: https://lore.kernel.org/all/sashiko-outbox-232396@kernel.org/
Link: https://lore.kernel.org/all/20261111-tool-pmu-leader-v2-1-3faa0fb98c5=
1@gmail.com/
Link: https://lore.kernel.org/all/awC_aZXD5FBGu4mO@google.com/
Link: https://lore.kernel.org/all/awTXdgY38s2bijW5@google.com/
Link: https://lore.kernel.org/all/20261123071913.653315-7-irogers@google.co=
m/

> diff --git a/tools/perf/tests/shell/stat+tool_group.sh b/tools/perf/tests=
/shell/stat+tool_group.sh
> new file mode 100755
> index 0000000000000..93860252593c6
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+tool_group.sh
> @@ -0,0 +1,326 @@
[ ... ]
> +# An hwmon event is read by perf from a sysfs file rather than opened wi=
th
> +# perf_event_open(), so it is in the same position as a tool event in a
> +# group.  Not every system has an hwmon PMU, and the name differs per ch=
ip.
> +hwmon=3D
> +for dir in /sys/bus/event_source/devices/hwmon_*; do
> +  if [ -e "${dir}" ]; then
> +    hwmon=3D$(basename "${dir}")
> +    break
> +  fi
> +done
[ ... ]
> +# An hwmon event reads a sysfs file, so the group is refused the same wa=
y.
> +# The message differs from the tool one, and the PMU has to be there to
> +# exercise it.
> +if [ -n "${hwmon}" ]; then
> +  refused "{cycles,${hwmon}}" "${hwmon}"
> +else
> +  echo "Testing that perf stat refuses a group of an hwmon event and cyc=
les  [Skipped]"
> +  skipped=3D$((skipped + 1))
> +fi

[Severity: Medium]
Can this hwmon test case ever run or pass?

perf synthesizes hwmon PMUs in userspace from /sys/class/hwmon/ in
perf_pmus__read_hwmon_pmus(), so /sys/bus/event_source/devices/hwmon_*
does not exist and the test is always skipped.

Even if an hwmon PMU is discovered, hwmon_pmu__new() leaves pmu.selectable
false, so passing a bare PMU name in "{cycles,${hwmon}}" fails in the
event parser with a syntax error (exit 129) rather than an event term such
as hwmon_<name>/<event>/.  In addition, pairing an hwmon event with cycles
is split into two ungrouped events by
parse_events__sort_events_and_fix_groups() because perf_pmu__is_software()
is false for both PMUs; keeping the group intact past the parser so it
reaches check_unopened_in_group() requires pairing the hwmon event with a
software PMU event such as cpu-clock.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125175450.2373=
258-1-takano32@gmail.com?part=3D1
