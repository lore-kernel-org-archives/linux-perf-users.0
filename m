From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: Perf ABI versioning
Date: Mon, 24 Jan 2011 18:28:54 +0100
Message-ID: <AANLkTinbOkn15TM3CC9pMmceb1V_gxWm8EBMKLxnM50J@mail.gmail.com>
References: <201101241704.01021.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-trace-users-owner@vger.kernel.org>
In-Reply-To: <201101241704.01021.trenn@suse.de>
Sender: linux-trace-users-owner@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: tardyp@gmail.com, acme@ghostprotocols.net, fweisbec@gmail.com, linux-perf-users@vger.kernel.org, mathieu.desnoyers@efficios.com, linux-trace-users@vger.kernel.org
List-Id: linux-perf-users.vger.kernel.org

Hi Thomas,

On Mon, Jan 24, 2011 at 5:04 PM, Thomas Renninger <trenn@suse.de> wrote=
:
> Hi,
>
> as I recently cleaned up the power events with
> some format/abi adjustings...
>
> I realized that it was rather easy to adjust
> the stuff in drivers/tools/perf, because there
> are some nice facilities to query which events
> are available.
>
> I looked at pytimechart, there it's not that nice
> and convenient would be some kind of version number.
>
> pytimechart can parse traces which are simply copied
> away from /sys/kernel/debug/trace and to check for
> available events and their format, one would have to
> do a separate, ugly to implement, iteration of parsing.
>
> Would it make sense to introduce a trace
> ABI version number?
> It would be enough to increase it by one every time
> any event (don't know about other perf facilities) is
> added, removed or modified.
> Ideally the modifications are tracked with a short
> description in a file like Documentation/trace/format.changes
>
> Untested, but the patch at the end should simply add
> a version number on top of
> /sys/kernel/debug/trace file

If needed the ABI versioning should at least contain a major and minor
number, i.e. 'x.y'.

The big question IMO is if it is needed or not. Is this a real problem
in the userland? Are the apps always fitting the kernel ABI in a
packaged distro?

>
> While this should be enough for the kernel, perf record
> would need to include it into it's binary perf.data format
> as well?
>
> Then userspace apps could easily test whether supported
> events would be included at all, whether only a subset of
> supported events were made available and which format they have.
>
> Does this make sense?
>
> Thanks,
>
> =A0 =A0Thomas
>

Regards,
Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-trace-u=
sers" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
