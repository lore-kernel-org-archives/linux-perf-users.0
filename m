From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
Subject: Re: [RFCv2] perf: proposed perf_event_open() manpage
Date: Tue, 6 Nov 2012 20:15:19 -0300
Message-ID: <20121106231519.GH3430@ghostprotocols.net>
References: <alpine.DEB.2.02.1211061748120.30004@vincent-weaver-1.um.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1211061748120.30004@vincent-weaver-1.um.maine.edu>
Sender: linux-kernel-owner@vger.kernel.org
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-man@vger.kernel.org, linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>, Stephane Eranian <eranian@gmail.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Tue, Nov 06, 2012 at 05:53:27PM -0500, Vince Weaver escreveu:
> .TP
> .IR "mmap"
> The
> .I mmap
> bit enables recording of extra information to a
> mmap'd ring-buffer.
> This is
> described below in subsection MMAP Layout.

Enables the recording of exec mmap events, its counterpart, for data
maps is...

> .IR "mmap_data" " (Since Linux 2.6.36)"
> Include mmap events in the ring_buffer.

That will include mmap events for data maps.
 
> .TP
> .IR "sample_id_all" " (Since Linux 2.6.38)"
> If set, then all sample ID info (TID, TIME, ID, CPU, STREAM_ID)
> will be provided.

No, it will obey sample_type for non SAMPLE PERF_RECORD_ events,
so if you want timestamps in all events so that you can detect
reordering, use it a sample_type with PERF_SAMPLE_TIME and
sample_id_all.
 
I'll read it again tomorrow, thanks for writing it!

- Arnaldo
