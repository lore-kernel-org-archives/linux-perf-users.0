From: Milian Wolff <mail@milianw.de>
Subject: Re: Haswell LBR call stacks - broken
Date: Wed, 05 Aug 2015 11:02:55 +0200
Message-ID: <1789536.mnTOPtGhsS@milian-kdab2>
References: <1682663.JO3lAz5bZo@agathebauer> <87h9oe3ox3.fsf@tassilo.jf.intel.com> <37D7C6CF3E00A74B8858931C1DB2F077018D21C6@SHSMSX103.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from dd17628.kasserver.com ([85.13.138.83]:49477 "EHLO
	dd17628.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbbHEJC6 (ORCPT
	<rfc822;linux-perf-users@vger.kernel.org>);
	Wed, 5 Aug 2015 05:02:58 -0400
In-Reply-To: <37D7C6CF3E00A74B8858931C1DB2F077018D21C6@SHSMSX103.ccr.corp.intel.com>
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: "Liang, Kan" <kan.liang@intel.com>
Cc: Andi Kleen <andi@firstfloor.org>, "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>

On Tuesday 04 August 2015 21:41:47 Liang, Kan wrote:
> Hi Milian,
> 
> Is it possible to share your test case/steps with me?

Sure, I hope Qt is fine with you.

main.cpp:
~~~~~~~~~~~~~~~~~~~~~~
#include <QString>
#include <QTextStream>

int main()
{
    QStringList haystack;
    for (int i = 0; i < 1000; ++i) {
        haystack << QString::number(i);
    }

    uint matches = 0;
    for (int i = 0; i < 1000; ++i) {
        foreach (const QString &str, haystack) {
            if (str == "needle") {
                ++matches;
            }
        }
    }

    QTextStream out(stdout);
    out << "Matches: " << matches << endl;

    return 0;
}

~~~~~~~~~~~~~~~~~~~~~~

lbr.pro:
~~~~~~~~~~~~~~~~~~~~~~
TEMPLATE = app

SOURCES = main.cpp

CONFIG += release
QMAKE_CXXFLAGS += -g
~~~~~~~~~~~~~~~~~~~~~~

To build, put both into a folder and then do:

~~~~~~~~~~~~~~~~~~~~~~
mkdir build
cd build
qmake-qt5 ..
make
perf record --call-graph lbr ./lbr
perf report --stdio
~~~~~~~~~~~~~~~~~~~~~~

> Does --call-graph fp work?

No, I'm on a 64bit architecture, and most libs (esp. Qt) is built without 
framepointers. --call-graph dwarf does work though.

Bye
-- 
Milian Wolff
mail@milianw.de
http://milianw.de
