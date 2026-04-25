Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E67436682A
	for <linux-perf-users@vger.kernel.org>; Sat, 25 Apr 2026 18:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140753; cv=none; b=pSUt7+Hb3b7j6wDqL03ymBcLu2csviebYWBqokCGP6QiJ5KUXW0GpEoupbGFMnKrcXV6h+PE4Y9IH7P9k87ul+c8RkFdoqEcK+vZ1Pt42qB/Xby88FtVhgeyh/D48LWtB6hqVjllkfosSO2Vr/zo/wj+Wt8hhl9o8PticO7R25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140753; c=relaxed/simple;
	bh=Syu5RyTVjtKsOKYhGU0wBxc2n2JtDkqPzibuukxp7ZY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MADrIHVkDImZgRVvOP/1gaPWExOL3BWxT4/EcEzeBcSzbI8ohX/VCSDSsBY+P/+nVTVqmX44EnbarqQUkHmyKhLeJCE54IKSbFZMQd6QMlj2m400I1++SK+ZiQaaLgB+WWpHwKyUZ1n6neQFp+9kabTbtkNYxZiujzXg21rP3Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LW05kytu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LW05kytu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34AC1C2BCB0;
	Sat, 25 Apr 2026 18:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777140753;
	bh=Syu5RyTVjtKsOKYhGU0wBxc2n2JtDkqPzibuukxp7ZY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=LW05kytuT/bBlOQ700yy1c0a/Q972oL62uC+97e6I4Lrsw8wlwsKdXBk2qOAK1qnk
	 PE+DUobYqgU9unWFOZGswP1Vrn8ravze6adQn4xTG9V0ImJxgfJzBAHeJ5nyYOQxjx
	 A8dxUAuHk9NZzhLt/XGYEXDnCkXAebg8ooYVQVOWr6mcw04RWyH/7TBBwUO9sCYDwG
	 UYJdAq35a5IlB3Kq+520AuYkJQ3vh5v27T6Nh3quOzBY0xn86f6swjyhUIQTCMtd6J
	 UZ00f/WtMZ3nt9c9MW+tvAOzVbkcMw3EBwOSAnLg7/b3Cirso7fOOscXeZHQL5IcA0
	 JipoWU59DnLYQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 41/59] perf netdev-times: Port netdev-times to use
 python module
Reply-To: sashiko@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
In-Reply-To: <20260425174858.3922152-42-irogers@google.com>
References: <20260425174858.3922152-42-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 18:12:32 +0000
Message-Id: <20260425181233.34AC1C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-perf-users@vger.kernel.org
List-Id: <linux-perf-users.vger.kernel.org>
List-Subscribe: <mailto:linux-perf-users+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-perf-users+unsubscribe@vger.kernel.org>

Sashiko AI review found 5 potential issue(s):
- [High] Inconsistent event name matching logic leads to KeyError crashes o=
n environments lacking the 'evsel(' wrapper.
- [High] Dropped packets (kfree_skb) are incorrectly printed as successfull=
y copied datagrams.
- [High] Missing 'consume_skb' handling for received SKBs leads to missed c=
onsumption events.
- [Medium] Argument parsing logic is disconnected from argparse definitions.
- [Medium] Softirq chunks that process zero packets are silently dropped.
--

commit 86da247cad062132ea413c0ac8dffb4e7574d66d
Author: Ian Rogers <irogers@google.com>

perf netdev-times: Port netdev-times to use python module
   =20
This patch ports the legacy Python script netdev-times.py to a Python 3
module using a class-based structure. It utilizes the perf.session API to
process events and collect traces.

> diff --git a/tools/perf/python/netdev-times.py b/tools/perf/python/netdev=
-times.py
> new file mode 100755
> index 000000000000..3fe46b4e7f21
> --- /dev/null
> +++ b/tools/perf/python/netdev-times.py
> @@ -0,0 +1,472 @@
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

When handle_kfree_skb() processes an event, it updates rec_data with both
'handle' and 'comm':

    rec_data.update({'handle': "kfree_skb",
                     'comm': comm, ...})

Will this cause kfree_skb events to match the "if 'comm' in event"
condition and mistakenly print as successfully copied datagrams?

[ ... ]
> +    def handle_irq_softirq_exit(self, event: dict) -> None:
> +        """Handle irq:softirq_exit event."""
> +        time =3D event['time']
> +        cpu =3D event['cpu']
> +        irq_list =3D []
> +        event_list =3D []
> +        sirq_ent_t =3D None
> +
> +        if cpu in self.irq_dic:
> +            irq_list =3D self.irq_dic[cpu]
> +            del self.irq_dic[cpu]
> +        if cpu in self.net_rx_dic:
> +            sirq_ent_t =3D self.net_rx_dic[cpu]['sirq_ent_t']
> +            event_list =3D self.net_rx_dic[cpu]['event_list']
> +            del self.net_rx_dic[cpu]
> +        if not irq_list or not event_list or sirq_ent_t is None:
> +            return

If a softirq execution processes no packets, event_list will be an empty
list. Since an empty list evaluates to false in Python, will this cause
chunks that process zero packets to be silently dropped?

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

Does this logic miss consumption events for received SKBs?

Unlike handle_kfree_skb(), which searches rx_skb_list for a matching
skbaddr, this function only iterates over tx_xmit_list. Could this leave
received SKBs in rx_skb_list without marking them as consumed?

[ ... ]
> +    def process_event(self, sample: perf.sample_event) -> None:
> +        """Process events directly on-the-fly."""
> +        name =3D str(sample.evsel)
> +        pid =3D sample.sample_pid
> +        if hasattr(self, 'session') and self.session:
> +            comm =3D self.session.find_thread(pid).comm()
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

Is it possible for the environment's perf bindings to omit the "evsel("
wrapper?

If name does not start with "evsel(", event_data['name'] will remain
unwrapped, so it can still successfully route via handle_single_event().

However, the "if name.startswith('evsel(')" branches here will be skipped,
meaning fields like 'irq' or 'skbaddr' won't be extracted.

Will this lead to KeyError crashes in handler functions like
handle_irq_handler_entry() when they try to access those missing fields?

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
> +        elif arg =3D=3D 'rx':
> +            parsed_args.rx =3D True
> +        elif arg.startswith('dev=3D'):
> +            parsed_args.dev =3D arg[4:]
> +        elif arg =3D=3D 'debug':
> +            parsed_args.debug =3D True

Is it intentional to manually iterate over sys.argv[1:] after setting up
and calling ap.parse_args()?

This approach seems to disconnect the argument parsing from the argparse
definitions. Valid argparse invocations, such as passing a device name
positionally, appear to be ignored.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260425174858.3922=
152-1-irogers@google.com?part=3D41
