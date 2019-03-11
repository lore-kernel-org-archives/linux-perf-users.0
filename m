From: "Hunter, Adrian" <adrian.hunter@intel.com>
Subject: RE: [PATCH v3 0/4] perf script python: add Python3 support
Date: Mon, 11 Mar 2019 09:27:07 +0000
Message-ID: <363DA0ED52042842948283D2FC38E4649C48CE08@IRSMSX106.ger.corp.intel.com>
References: <20190309000518.2438-1-tonyj@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190309000518.2438-1-tonyj@suse.de>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Jones <tonyj@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>, "acme@kernel.org" <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

> -----Original Message-----
> From: Tony Jones [mailto:tonyj@suse.de]
> Sent: Saturday, March 9, 2019 2:05 AM
> To: linux-kernel@vger.kernel.org
> Cc: linux-perf-users@vger.kernel.org; acme@kernel.org; Tony Jones
> <tonyj@suse.de>; Hunter, Adrian <adrian.hunter@intel.com>; Arnaldo
> Carvalho de Melo <acme@redhat.com>; Seeteena Thoufeek
> <s1seetee@linux.vnet.ibm.com>
> Subject: [PATCH v3 0/4] perf script python: add Python3 support
> 
> This is v3 of my version of the patchset.
> 
> The exporter and viewer changes were all in one patch for V2.
> For V3 I split them into 3 patches for the reasons below.
> 
> Patch#1 adds Python3 support to exported-sql-viewer
> Patch#2 adds Python3 support to export-to-postgresql
> Patch#3 adds Python3 support to export-to-sqlite
> Patch#4 cleans up some repeated use of date functions in the code.
> 
> I added Adrian's signed-off-by to Patch#2 per the revised patch he sent in his
> review of V2.
> 
> The content of patches 1, 3 and 4 is unchanged from V2 but I'm including all
> the patches again to hopefully make your application easier. I added Adrian's
> Acked-by to Patch#4 per his review of that patch in V2.
> 
> Once these are applied I believe this is everything needed to run on a system
> without Python2.

All look fine to me.  Here is my ack as needed:

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
