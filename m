From: Tony Jones <tonyj@suse.de>
Subject: Re: [PATCH v2 0/7] perf script python: add Python3 support
Date: Tue, 5 Mar 2019 06:53:05 -0800
Message-ID: <962077f0-71c6-e2e8-7274-875b55470a3e@suse.de>
References: <20190302011903.2416-1-tonyj@suse.de>
 <ef75a243-cf15-b763-8aeb-387f105377c6@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ef75a243-cf15-b763-8aeb-387f105377c6@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>, Feng Tang <feng.tang@intel.com>, Tom Zanussi <tzanussi@gmail.com>, Seeteena Thoufeek <s1seetee@linux.vnet.ibm.com>
List-Id: linux-perf-users.vger.kernel.org

On 3/5/19 1:55 AM, Adrian Hunter wrote:

> perf tools link against python2 so have the scripts been tested with python3?

Not if PYTHON=python3 is specified on the build line.   Yes, of course they were tested.
 
