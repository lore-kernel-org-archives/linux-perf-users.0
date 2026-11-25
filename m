Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573049;
	b=GorOm8izWtq8cuZIDeeuxIqZCo58v/XDE60t6Fw/6H/Cc0cbfSfwOHaPaHk3NTpt2M5F
	 8xN5WS79wNJ5Xyu++WSgibazjHQ/weCN2heUerbCW/XGMIJsWDsCdLLYKzIy4GY2ejaAj
	 p+EOyBpkQAqHNwVcLnmBBjqyQv+h4zbh4zJqvnYxS/nXxq4zeskWjgTBKh0MvVmQ+/fTg
	 F+oZNa601QZrMaReKujvPx67UVKFPlri32XK4PWpgJxrkloazwWBv2A8Akyd7slBB6vK6
	 YZat7xMFopKFyOqnWcpZvBwby+HJLc60fl60BbqSFmmctXoEL7kxWYqIDIJ+5jyEWYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573049;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SPbiQBdJAUd+QqTmNIFCXrbkatS9bA90y2l8ZVhkUGM=;
	b=AwIJ934lgqbmxEGaau5rtFhNuVNLDY25E367UgKYNi7qHyXqsIYS8EdofmItYp8tVHSX
	 DgMblqEbPmrTXp/hXWTBEZ6MTCYSfNlH6wwtaei5+Sc1jHknHWJEIFKNavSmBXrzfl9Wh
	 T4Vk4bZoO4tG8hL8JBWSzHwj+MSXUW7PDYFt+je8n0mncnvNeqK0aD8MJ9Gs4zEWKo+9m
	 fjxa87dTF8lm12XbGoibdF1sLBZl3mNzfCZgsWQuhxel1sijNoLnQZ6DtF3pbGdGMaaJj
	 NTopROqhZ17KSPsV4lSFBjBNmSjN6loKBAfTSvy5A6NmT+3PujkkWC9Ta+xaWDysZEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hb61Gkw6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E463606A31E
	for <linux-perf-users@vger.kernel.org>; Wed, 25 Nov 2026 02:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hb61Gkw6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8891D1F000D2;
	Wed, 25 Nov 2026 02:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795573048;
	bh=SPbiQBdJAUd+QqTmNIFCXrbkatS9bA90y2l8ZVhkUGM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=Hb61Gkw6WVqSBC3teyO+r0cjmE6th/H+PMiWBjwlYON2kOJlC35FriCIYrIl45Ji3
	 RIqZA9fKNCY8cPMJ1NSYhWcQsGV9KMuuw2s18OU+kXQeDxPc61bk/RmXy6PZypETF3
	 qBJjXbnl++s5b1lQ9YJn1EHHsIyYLBO1hoayJk/wlglKnUhZz/apY8a70SJTCxHBNh
	 MAV8hBIHBcIvXEmy27z5X8AxzQ4FDhhU4zA1UvidjW+D2akOO8WMhxjKnNrBKwDncl
	 4oyX9Bs5v+upud2odbahPn2POZhTO0NIT5NSY5jSIAuL9BlNNNIkzsm9FAFxte+Dij
	 1A298fU3bWs7A==
Message-ID: <sashiko-outbox-232396@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6] perf stat: Refuse a group mixing tool and kernel
 events
Reply-To: sashiko-reviews@lists.linux.dev
To: "TAKANO Mitsuhiro" <takano32@gmail.com>, linux-perf-users@vger.kernel.org
In-Reply-To: <20261125013826.1495729-1-takano32@gmail.com>
References: <20261124135630.1027716-1-takano32@gmail.com>
 <20261125013826.1495729-1-takano32@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:17:26 +0000
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Post: <mailto:linux-perf-users@vger.kernel.org>
List-Help: <mailto:linux-perf-users+help@vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-perf-users+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] perf tests: per-task <not counted> failure on hybrid PMUs in
  accepted()
- [Medium] perf stat: NULL deref in evsel__enable_cpu() on unsplit weak
  tool group
--

commit 102728bd68653615df5786d4a884d15a2f55a157
Author: TAKANO Mitsuhiro <takano32@gmail.com>

perf stat: Refuse a group mixing tool and kernel events

This commit rejects event groups that mix tool PMU events with kernel events
in perf stat, while leaving weak groups led by a tool event to the open-loop
weak group splitting logic and returning -2 from get_group_fd() for any tool
leader.

Link: https://lore.kernel.org/all/sashiko-outbox-227849@kernel.org/
Link: https://lore.kernel.org/all/sashiko-outbox-231330@kernel.org/
Link: https://lore.kernel.org/all/20261111-tool-pmu-leader-v2-1-3faa0fb98c5=
1@gmail.com/
Link: https://lore.kernel.org/all/awC_aZXD5FBGu4mO@google.com/
Link: https://lore.kernel.org/all/awTXdgY38s2bijW5@google.com/
Link: https://lore.kernel.org/all/20261123071913.653315-7-irogers@google.co=
m/

> diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> index 37752d6bfef45..21cf17d3dcca8 100644
> --- a/tools/perf/builtin-stat.c
> +++ b/tools/perf/builtin-stat.c
> @@ -2469,6 +2469,70 @@ static int parse_tpebs_mode(const struct option *o=
pt, const char *str,
>  }
>  #endif // HAVE_ARCH_X86_64_SUPPORT
> =20
> +/*
> + * A tool event like user_time has no event in the kernel: perf reads it
> + * from a file such as /proc/stat, or computes it in perf itself.  A gro=
up
> + * that mixes one with an event the kernel opens cannot be counted.
> + * get_group_fd() has no group fd to hand to the members when the leader=
 is
> + * a tool event, so the members cannot be in a kernel group with it; with
> + * a kernel event as the leader the members do open, but the group read =
is
> + * rejected as the kernel knows only the members it opened.  perf stat u=
sed
> + * to leave the rest of the group uncounted in both cases, when the CPU =
maps
> + * had not split the group first; refuse the group instead.  A group wit=
h no
> + * event the kernel opens is left alone, as perf reads each event in it.=
  A
> + * weak group led by a tool event is left to the weak group handling in =
the
> + * open loop, which splits it when a member fails to open; any other weak
> + * group is refused like a strong one.
> + */
> +static int check_tool_groups(struct evlist *evlist)
> +{
> +	struct evsel *leader, *evsel;
> +
> +	evlist__for_each_entry(evlist, leader) {
> +		struct evsel *tool =3D NULL;
> +		bool has_kernel =3D false, weak =3D false;
> +
> +		if (!evsel__is_group_leader(leader) || leader->core.nr_members < 2)
> +			continue;
> +
> +		/*
> +		 * The members of a group are not necessarily adjacent in the
> +		 * evlist: evlist__check_cpu_maps() makes a removed member a
> +		 * leader of its own without moving it.
> +		 */
> +		evlist__for_each_entry(evlist, evsel) {
> +			if (!evsel__has_leader(evsel, leader))
> +				continue;
> +			if (evsel__is_tool(evsel)) {
> +				if (!tool)
> +					tool =3D evsel;
> +			} else if (!evsel__is_non_perf_event_open_pmu(evsel)) {
> +				has_kernel =3D true;
> +			}
> +			weak |=3D evsel->weak_group;
> +		}
> +
> +		if (!tool || !has_kernel)
> +			continue;
> +
> +		/*
> +		 * A weak group led by a tool event is left to the weak group
> +		 * handling in the open loop: get_group_fd() returns -2 for a
> +		 * tool leader, the open fails with EINVAL, and that is what
> +		 * splits the group.  Any other weak group does not get that
> +		 * far, so it is refused like a strong group.
> +		 */
> +		if (weak && evsel__is_tool(leader))
> +			continue;

[Severity: Medium]
Can a weak group led by a tool event still reach enable_counters() with an
unsplit member whose core.fd is NULL, causing a NULL pointer dereference in
evsel__enable_cpu()?

With a retire-latency member (for example,
perf stat -a -e '{user_time,cycles:R}:W' -- true), evsel__open_cpu() returns
early after evsel__tpebs_open() before allocating core.fd or calling
get_group_fd(), so the weak group is never split.  Similarly, with an
architecture force-grouped member and :WX (for example,
perf stat -a -e '{user_time,slots}:WX' -- true on x86),
evsel__remove_from_group() refuses to detach a member where
arch_evsel__must_be_in_group() is true, so the second pass fails again in
get_group_fd() and perf_evsel__free_fd() sets member->core.fd to NULL while
leaving it attached to the tool leader:

tools/perf/util/evsel.c:evsel__remove_from_group() {
	if (!arch_evsel__must_be_in_group(evsel) && evsel !=3D leader) {
		evsel__set_leader(evsel, evsel);
		evsel->core.nr_members =3D 0;
		leader->core.nr_members--;
	}
}

When !target__enable_on_exec(&target), __evlist__enable() checks
pos->core.fd only on the tool leader and calls evsel__enable_cpu(leader),
which loops over remaining group members and calls
perf_evsel__enable_cpu(&member->core) -> perf_evsel__run_ioctl() ->
xyarray__max_y(NULL).

> diff --git a/tools/perf/tests/shell/stat+tool_group.sh b/tools/perf/tests=
/shell/stat+tool_group.sh
> new file mode 100755
> index 0000000000000..ff71429779792
> --- /dev/null
> +++ b/tools/perf/tests/shell/stat+tool_group.sh

[ ... ]

> +accepted() {
> +  local group=3D"$1" name rc=3D0
> +
> +  shift
> +  echo "Testing that perf stat accepts ${group}"
> +  perf stat -e "${group}" -o "${out}" -- true 2> "${stderr}" || rc=3D$?
> +
> +  if [ "${rc}" !=3D 0 ]; then
> +    cat "${stderr}"
> +    echo "perf stat failed for ${group} (${rc})  [Failed]"
> +    err=3D1
> +    return
> +  fi
> +  if grep -q "cannot be grouped with kernel events" "${stderr}"; then
> +    cat "${stderr}"
> +    echo "perf stat refused ${group}  [Failed]"
> +    err=3D1
> +    return
> +  fi
> +  for name in "$@"; do
> +    # When no hardware cycles event can be counted, cycles falls back to
> +    # task-clock and the evsel is renamed, so it need not appear.
> +    case "${name}" in
> +      cycles|cycles:*)
> +        [ "${kernel_events}" =3D 0 ] && continue ;;
> +    esac
> +    if ! grep -q -- "${name}" "${out}"; then
> +      echo "perf stat did not print ${name}  [Failed]"
> +      cat "${out}"
> +      err=3D1
> +    fi
> +  done
> +  if grep -q "<not counted>" "${out}"; then
> +    echo "perf stat did not count an event in ${group}  [Failed]"
> +    cat "${out}"
> +    err=3D1

[Severity: Medium]
Will this "<not counted>" check in accepted() fail on hybrid systems when
running the per-task test cases such as '{user_time,cycles}:W' and
'{cycles,instructions},duration_time'?

On hybrid machines (such as Intel Alder Lake or ARM big.LITTLE), unqualified
cycles and instructions expand into one evsel per core PMU (for example,
cpu_core/cycles/ and cpu_atom/cycles/).  Because the initial kernel_events
probe only checks for "<not supported>", kernel_events remains 1, and a
short-lived per-task run of "true" without --hybrid-merge executes on only
one core type while printing "<not counted>" for the unused core PMU.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125013826.1495=
729-1-takano32@gmail.com?part=3D1
