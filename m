From: Vlastimil Babka <vbabka@suse.cz>
Subject: perf top out of bounds address warnings when zoomed to kernel DSO
Date: Wed, 05 Nov 2014 14:50:16 +0100
Message-ID: <545A2B18.1080101@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:50946 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753191AbaKENuS (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Nov 2014 08:50:18 -0500
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org
Cc: lkml <linux-kernel@vger.kernel.org>

Hi,

when running perf top, immediately after zooming into kernel DSO I star=
t getting
tons of warnings like these, always for some userspace binary:

=E2=94=8C=E2=94=80Warning:=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=90
=E2=94=82Out of bounds address found:                     =E2=94=82
=E2=94=82                                                 =E2=94=82
=E2=94=82Addr:   5d558                                    =E2=94=82
=E2=94=82DSO:    /bin/bash f                              =E2=94=82
=E2=94=82Map:    400000-4ab000                            =E2=94=82
=E2=94=82Symbol: 5d4e0-5d4ef g malloc@plt                 =E2=94=82
=E2=94=82Arch:   x86_64                                   =E2=94=82
=E2=94=82Kernel: 3.18.0-rc3                               =E2=94=82
=E2=94=82Tools:  3.17.2                                   =E2=94=82
=E2=94=82                                                 =E2=94=82
=E2=94=82Not all samples will be on the annotation output.=E2=94=82
=E2=94=82                                                 =E2=94=82
=E2=94=82Please report to linux-kernel@vger.kernel.org    =E2=94=82
=E2=94=82                                                 =E2=94=82
=E2=94=82                                                 =E2=94=82
=E2=94=82Press any key...                                 =E2=94=82
=E2=94=94=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=98

Vlastimil
