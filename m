From: Benjamin King <benjaminking@web.de>
Subject: How to sample memory usage cheaply?
Date: Thu, 30 Mar 2017 22:04:04 +0200
Message-ID: <20170330200404.GA1915@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Return-path: <linux-perf-users-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:63061 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934711AbdC3UEH (ORCPT <rfc822;linux-perf-users@vger.kernel.org>);
        Thu, 30 Mar 2017 16:04:07 -0400
Received: from localhost ([31.19.65.168]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lp71s-1cF8LY2miy-00eqY1 for
 <linux-perf-users@vger.kernel.org>; Thu, 30 Mar 2017 22:04:04 +0200
Content-Disposition: inline
Sender: linux-perf-users-owner@vger.kernel.org
List-ID: <linux-perf-users.vger.kernel.org>
To: linux-perf-users@vger.kernel.org

Hi,

I'd like to get a big picture of where a memory hogging process uses physical
memory. I'm interested in call graphs, but in terms of Brendans treatise
(http://www.brendangregg.com/FlameGraphs/memoryflamegraphs.html), I'd love to
analyze page faults a bit before continuing with the more expensive tracing
of malloc and friends.

My problem is that we mmap some readonly files more than once to save memory,
but each individual mapping creates page faults.

This makes sense, but how can I measure physical memory properly, then?
Parsing the Pss-Rows in /proc/<pid>/smaps does work, but seems a bit clumsy.
Is there a better way (e.g. with callstacks) to measure physical memory
growth for a process?

cheers,
  Benjamin

PS:
 Here is some measurement with a leaky toy program. It uses a 1GB zero-filled
 file and drops file system caches prior to the measurement to encourage
 major page faults for the first mapping only. Does not work at all:
-----
$ gcc -O0 mmap_faults.c
$ fallocate -z -l $((1<<30)) 1gb_of_garbage.dat 
$ sudo sysctl -w vm.drop_caches=3
vm.drop_caches = 3
$ perf stat -eminor-faults,major-faults ./a.out

 Performance counter stats for './a.out':

            327,726      minor-faults                                                
                  1      major-faults
$ cat mmap_faults.c
#include <fcntl.h>
#include <sys/mman.h>
#include <unistd.h>

#define numMaps 20
#define length 1u<<30
#define path "1gb_of_garbage.dat"

int main()
{
  int sum = 0;
  for ( int j = 0; j < numMaps; ++j ) 
  { 
    const char *result =
      (const char*)mmap( NULL, length, PROT_READ, MAP_PRIVATE,
          open( path, O_RDONLY ), 0 );

    for ( int i = 0; i < length; i += 4096 ) 
      sum += result[ i ];
  } 
  return sum;
}
-----
Shouldn't I see ~5 Million page faults (20GB/4K)? 
Shouldn't I see more major page faults?
Same thing when garbage-file is filled from /dev/urandom
Even weirder when MAP_POPULATE'ing the file
