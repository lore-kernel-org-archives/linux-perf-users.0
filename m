Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2923CCFC8
	for <linux-perf-users@vger.kernel.org>; Thu, 23 Apr 2026 04:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776917465; cv=none; b=VVpUBVHcGXL2L4qZCUAVEPQyulWsBEipbqJ7kgjUeXuRyJlWI9GPjIc9oigMtVF5REXr9kITjG7t/oc2jF75X4YcWFLoKOWQGYEO7RrJfGIFLBtm/knAYVvVIA4SCsv1rAX0bqKDaLVjdEmRm1KjaIYjDYoxQPqFlhmWiB1Lurc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776917465; c=relaxed/simple;
	bh=SvADZ5i0bin4ZezXuyvTEFwzA6vEZU84FgdhlnLZ4Aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UJrEG7Zf6ZRHAokLTpFi5WNhl/MXVyLz/X7XVhoDakfwk/MrS1dkGwFnljrVGWWUxHkgFbXF11w69lUz21e7U5G68SRqHrksvNmOt8mexjPX9Ete1aWOjeTkGTgQMVJ/UauYzrPfvRnbmvoov1+fiKJMG9jZRJvf4JpxKPgtj/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JK43xPVp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JK43xPVp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5477BC2BCB2;
	Thu, 23 Apr 2026 04:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776917464;
	bh=SvADZ5i0bin4ZezXuyvTEFwzA6vEZU84FgdhlnLZ4Aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=JK43xPVpecPPTLpMDSwZkSANKjlPVydjMQqn2oJmXKqEhPrtVSsvOXoledbTVMa1t
	 sKmjPF0tCMKm8zo7p7GdMyaEUMpp9ZTBOgnFjgZjgWZhYYTpF+y5Ytf7IhXInuNSnw
	 dS8m+R1VJLb1ME1Nd4+zxTavlWuOfEyCkRDgfTGxO44tB8dTfjmfUSZpg+J6ZJHP20
	 spqlH7wwTxRKkKMA+mR7Ah2uRe7DjkDpxJ9UWngkWpGjGEXBAUIARJWape57IemQyl
	 /bQVqBJKzvBSnS/VYxc/a+oyFP+opEdpgYosbnAussx412tNukqGyrRUbT1X6oPCVL
	 gwjW/zgMi1+QQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 41/58] perf netdev-times: Port netdev-times to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260423035526.1537178-42-irogers@google.com>
References: <20260423035526.1537178-42-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Apr 2026 04:11:03 +0000
Message-Id: <20260423041104.5477BC2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 6 potential issue(s):
- [High] Brittle string matching for the `evsel(` prefix will cause unhandl=
ed `KeyError` exceptions if the prefix is missing.
- [High] `consume_skb` events for received packets are ignored because `han=
dle_consume_skb` skips the receive list.
- [High] `print_receive()` falsely prints `kfree_skb` events as `skb_copy_d=
atagram_iovec` due to shadowed dictionary keys.
- [Medium] The commit message contradicts the actual code execution regardi=
ng event processing order.
- [Medium] Manual iteration over `sys.argv[1:]` conflicts with `argparse`, =
treating arbitrary arguments or input filenames as command flags.
- [Medium] The use of `list.insert(0, ...)` on large bounded arrays creates=
 an O(N^2) performance bottleneck.
--

commit fd34e11e0e39840623949e7e6ae5732c89401b44
Author: Ian Rogers <irogers@google.com>

perf netdev-times: Port netdev-times to use python module

This commit ports the netdev-times script to Python 3, refactoring it
to use a class structure and the perf.session module to collect and
process events.

> perf netdev-times: Port netdev-times to use python module
>=20
> Ported from tools/perf/scripts/python/.
> - Refactored the script to use a class structure (NetDevTimesAnalyzer)
>   to encapsulate state.
> - Used perf.session for event collection and processed them in time
>   order at the end to match legacy behavior.

Does the commit message accurately reflect the implementation? The code in
process_event() appears to call handle_single_event() immediately, processi=
ng
events on the fly as they are received rather than collecting them for
end-of-run time ordering.

> - Extracted tracepoint fields directly from sample attributes.
> - Moved format string constants to module level.
> - Cleaned up Python 2 compatibility artifacts (like cmp_to_key).
>=20
> Assisted-by: Gemini:gemini-3.1-pro-preview
> Signed-off-by: Ian Rogers <irogers@google.com>

diff --git a/tools/perf/python/netdev-times.py b/tools/perf/python/netdev-t=
imes.py
new file mode 100755
index 0000000000000..568986e2d4924
--- /dev/null
+++ b/tools/perf/python/netdev-times.py
[ ... ]
> +    def print_receive(self, hunk: dict) -> None:
[ ... ]
> +            else:
> +                print(PF_NET_RECV %
> +                      (self.diff_msec(base_t, event['event_t']),
> +                       event['skbaddr'],
> +                       event['len']))
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

Will kfree_skb events be misreported as skb_copy_datagram_iovec here?
Since handle_kfree_skb() also injects the 'comm' key into the event, the
first condition ('comm' in event) will evaluate to true, preventing the
'handle' in event branch from executing.

[ ... ]
> +    def handle_netif_receive_skb(self, event: dict) -> None:
> +        """Handle net:netif_receive_skb event."""
> +        time =3D event['time']
> +        cpu =3D event['cpu']
> +        skbaddr =3D event['skbaddr']
> +        skblen =3D event['skblen']
> +        if cpu in self.net_rx_dic:
> +            rec_data =3D {'event_name': 'netif_receive_skb',
> +                        'event_t': time, 'skbaddr': skbaddr, 'len': skbl=
en}
> +            event_list =3D self.net_rx_dic[cpu]['event_list']
> +            event_list.append(rec_data)
> +            self.rx_skb_list.insert(0, rec_data)

Could inserting at the beginning of the list cause a performance bottleneck?
In Python, inserting at index 0 requires shifting all subsequent elements.
With the list bounded to 65,536 elements, this could degrade execution time
when processing many events.

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

Does this function also need to loop through self.rx_skb_list, similarly
to handle_kfree_skb()? By skipping the receive list, incoming packet events
will never be matched with their consume_skb counterpart, and they will not
be reported properly in print_receive().

[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events directly on-the-fly."""
> +        name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid
> +        if hasattr(self, 'session') and self.session:
> +            comm =3D self.session.process(pid).comm()
> +        else:
> +            comm =3D "Unknown"
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
> +            event_data['vec'] =3D getattr(sample, "vec", 0)
> +            # Filter for NET_RX
> +            try:
> +                if perf.symbol_str("irq:softirq_entry", "vec",  # type: =
ignore
> +                                   event_data['vec']) !=3D "NET_RX":
> +                    return
> +            except AttributeError:
> +                # Fallback if symbol_str not available or fails
> +                if event_data['vec'] !=3D 3:  # NET_RX_SOFTIRQ is usuall=
y 3
> +                    return
> +        elif name =3D=3D "evsel(irq:irq_handler_entry)":

What happens if str(sample.evsel) lacks the "evsel(" prefix?
The condition for extracting tracepoint-specific fields would fail.
Since the event name in event_data has the prefix stripped, it would still
be dispatched to handle_irq_handler_entry(), which would then try to access
event['irq'] and result in a KeyError crash.

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
> +            parsed_args.tx =3D True

Is there a chance this manual loop over sys.argv conflicts with argparse?
If a user passes an input file named "tx" via "-i tx" or "--input tx", the
manual loop will see the string "tx" and incorrectly activate parsed_args.t=
x.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423035526.1537=
178-1-irogers@google.com?part=3D41
