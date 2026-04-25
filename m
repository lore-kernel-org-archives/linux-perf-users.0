Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ECC313E38
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777158462; cv=none; b=NJE+m1cztJ575p6hPY5SuPjMLBx7VqiG7hNKa+Ms4Zf8GuOxTRTjLKt7AMj17Gh7tfL80721hseVZHBx+INlddlAgQ9gKnSUuVx6JG7TWMFhEvqkTFQ5a1TaU4qp1kwVSLAQfV6NpdynqHzBQFeabEJTSEQuVlcpPhZ2fcZt93Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777158462; c=relaxed/simple;
	bh=Bml/a9EzcoGm8A5LBBT3t0PmuGIGUKiD9HxiT9AOo18=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rSVPUepRRTTwoufVvXzy3f+oxSi5fnAreyrAvYe96JpDTITNPfbZZGKWNRvf576L9Pd0AWbyUzzU4I/DeWlIFlrXuXNoqI4/KeYWuI1sQSG8UcVTB0erG/OwtVdoDzOQLupLkeoF17/wsqHbvR6xBNRbdSpQENAJH71C+Fee2eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PRid2Ffy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PRid2Ffy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DD10C2BCB0;
	Sat, 25 Apr 2026 23:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777158461;
	bh=Bml/a9EzcoGm8A5LBBT3t0PmuGIGUKiD9HxiT9AOo18=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=PRid2FfyCrEJ9Ultl8AtTsSC2NBj3ieRtxLssRVoqCsnMoxhHxZzBBPrYFq3RsTBA
	 17ntSwmnKerALUrDtnEGNXcfZtUmTow/ap29RIN4DorXOWnKbJ4K2PCddDqY3GzVZa
	 cL9lSfY2qUxZ2tOY9BLKB2Z9wCQrYuLg5DuaGq5D1DS/i7lkXWXUGUDXkwl5SW9m/E
	 4PKtjsG3fRmqn51wczuRu3R5ePCTJp0naIiI95Mq7W9LED5qTeD20vDi/rF3f0mrKE
	 rmwsvIgfMLtyEBTkRNr/CowkExnh0gBhypfFpL11LRJKmyhmab7pHNo6wYLtv1wA8u
	 kP1IJufcWQdhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 41/59] perf netdev-times: Port netdev-times to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425224951.174663-42-irogers@google.com>
References: <20260425224951.174663-42-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 23:07:41 +0000
Message-Id: <20260425230741.9DD10C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [High] Unhandled exception when calling `.comm()` on an unknown thread ca=
uses the script to crash.
- [Medium] RX `kfree_skb` events are incorrectly misidentified and printed =
as `skb_copy_datagram_iovec`.
- [Medium] Brittle event name matching can bypass attribute extraction and =
cause KeyErrors.
- [Medium] `handle_consume_skb` completely omits RX tracking, leaving succe=
ssfully delivered packets untracked.
- [Low] Manual iteration over `sys.argv` ignores `argparse` validation and =
introduces brittle parsing behavior.
- [Low] Incorrect attribute extraction for `skb:skb_copy_datagram_iovec` re=
quests `skblen` instead of `len`.
--

commit 38c100f5ac87ac6f769261a5e074d27809005ec6
Author: Ian Rogers <irogers@google.com>
perf netdev-times: Port netdev-times to use python module

This commit ports the netdev-times script to a Python module format.
It uses a class structure to encapsulate state and processes events using
perf.session in time order. Tracepoint fields are directly extracted
from sample attributes.

> diff --git a/tools/perf/python/netdev-times.py b/tools/perf/python/netdev=
-times.py
> new file mode 100755
> index 000000000000..3fe46b4e7f21
> --- /dev/null
> +++ b/tools/perf/python/netdev-times.py
[ ... ]
> +    def print_receive(self, hunk: dict) -> None:
[ ... ]
> +                if 'comm' in event:
> +                    print(PF_WJOINT)
> +                    print(PF_CPY_DGRAM %
> +                          (self.diff_msec(base_t, event['comm_t']),
> +                           event['pid'], event['comm']))
> +                elif 'handle' in event:
> +                    print(PF_WJOINT)
> +                    if event['handle'] =3D=3D "kfree_skb":
> +                        print(PF_KFREE_SKB %
> +                              (self.diff_msec(base_t, event['comm_t']),
> +                               event['location']))

Because handle_kfree_skb() updates rec_data with a 'comm' key, will the
check here for 'comm' match first? This appears to cause kfree_skb events
to be misidentified and printed using the PF_CPY_DGRAM format instead of
PF_KFREE_SKB, making the kfree_skb block dead code.

[ ... ]
> +    def handle_consume_skb(self, event: dict) -> None:
> +        """Handle skb:consume_skb event."""
> +        time =3D event['time']
> +        skbaddr =3D event['skbaddr']
> +        for i, skb in enumerate(self.tx_xmit_list):
> +            if skb['skbaddr'] =3D=3D skbaddr:
> +                skb['free_t'] =3D time
> +                self.tx_free_list.append(skb)
> +                del self.tx_xmit_list[i]
> +                return

Does this omit receive tracking for consumed SKBs? The handler only iterates
over tx_xmit_list and returns, failing to check rx_skb_list. This would
leave successfully delivered packets untracked on the receive path,
leaving the consume_skb format logic in print_receive() unused.

[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events directly on-the-fly."""
> +        name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid
> +        if hasattr(self, 'session') and self.session:
> +            comm =3D self.session.find_thread(pid).comm()
> +        else:
> +            comm =3D "Unknown"

Can this cause an unhandled exception if find_thread(pid) returns None?
For idle threads or PIDs missing PERF_RECORD_COMM, find_thread() can fail,
and calling .comm() directly on the result could crash the script.

> +        event_data =3D {
> +            'name': name[6:-1] if name.startswith("evsel(") else name,
> +            'time': sample.sample_time,
> +            'cpu': sample.sample_cpu,
> +            'pid': pid,
> +            'comm': comm,
> +        }
> +
> +        # Extract specific fields based on event type
> +        if name.startswith("evsel(irq:softirq_"):

Does the event name extraction safely handle cases where the event
name does not start with "evsel("? The event_data 'name' handles this,
but the subsequent if/elif chain uses the raw 'name' string and hardcodes
the "evsel(" wrapper. If the string representation lacks this prefix, the
fields might not be extracted, leading to a KeyError later.

[ ... ]
> +        elif name =3D=3D "evsel(skb:skb_copy_datagram_iovec)":
> +            event_data['skbaddr'] =3D getattr(sample, "skbaddr", 0)
> +            event_data['skblen'] =3D getattr(sample, "skblen", 0)

Is skblen the correct attribute here? The kernel tracepoint for
skb:skb_copy_datagram_iovec exports this field as "len", so this might
silently default to 0.

[ ... ]
> +if __name__ =3D=3D "__main__":
> +    ap =3D argparse.ArgumentParser(description=3D"Display a process of p=
ackets and processed time.")
> +    ap.add_argument("-i", "--input", default=3D"perf.data", help=3D"Inpu=
t file name")
> +    ap.add_argument("tx", nargs=3D"?", help=3D"show only tx chart")
> +    ap.add_argument("rx", nargs=3D"?", help=3D"show only rx chart")
> +    ap.add_argument("dev", nargs=3D"?", help=3D"show only specified devi=
ce")
> +    ap.add_argument("debug", nargs=3D"?", help=3D"work with debug mode. =
It shows buffer status.")
> +    args =3D ap.parse_args()
> +
> +    parsed_args =3D argparse.Namespace(tx=3DFalse, rx=3DFalse, dev=3DNon=
e, debug=3DFalse, input=3Dargs.input)
> +
> +    for arg in sys.argv[1:]:
> +        if arg =3D=3D 'tx':

Is it expected to iterate directly over sys.argv[1:] here? If an argparse
option like "-i tx" is passed, the manual loop might see 'tx' and
erroneously enable the transmit chart mode instead of respecting the
argparse validation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425224951.1746=
63-1-irogers@google.com?part=3D41
