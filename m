From: Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 2/3 v2] perf alias: Rebuild alias expression string to
 make it comparable
Date: Tue, 19 Jun 2018 12:16:21 -0300
Message-ID: <20180619151621.GI20477@kernel.org>
References: <20180615101105.47047-1-tmricht@linux.ibm.com>
 <20180615101105.47047-2-tmricht@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180615101105.47047-2-tmricht@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, brueckner@linux.vnet.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, Jiri Olsa <jolsa@redhat.com>
List-Id: linux-perf-users.vger.kernel.org

Em Fri, Jun 15, 2018 at 12:11:04PM +0200, Thomas Richter escreveu:
> PMU alias definitions in sysfs files may have spaces, newlines
> and numbers with leading zeroes. Some alias definitions may
> also appear in JSON files without spaces, etc.
> 
> Scan alias definitions and remove leading zeroes, spaces,
> newlines, etc and rebuild string to make alias->str member
> comparable.
> 
> s390 for example  has terms specified as
> event=0x0091 (read from files ../<PMU>/events/<FILE>
> and terms specified as event=0x91 (read from JSON files).

Applying, I think Jiri agreed with this one in the v1 post, right?

- Arnaldo
